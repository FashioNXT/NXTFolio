class RoomController < ApplicationController
  def show
    user_key_current = params[:user_key] || session[:current_user_key]
    return redirect_to "/login_info/login" if user_key_current.nil?

    @user = GeneralInfo.find_by(userKey: user_key_current)
    return redirect_to "/login_info/login" unless @user

    fetch_users_and_notifications(user_key_current)

    if params[:id]
      setup_chat(params[:id])
      handle_notifications
    end

    fetch_general_info(user_key_current)
  end

  def create_message
    user_key_current = params[:user_key] || session[:current_user_key]
    return redirect_to "/login_info/login" if user_key_current.nil?

    @user = GeneralInfo.find_by(userKey: user_key_current)
    return redirect_to "/login_info/login" unless @user

    create_new_message(params[:id], params[:body], params[:files]) if params[:id]
  end

  private

  def fetch_users_and_notifications(user_key_current)
    user_ids = Message.where("general_info_id = ? OR chatting_with = ?", @user[:id], @user[:id])
                      .pluck(:general_info_id, :chatting_with)
                      .flatten.uniq

    @users = user_ids.present? ? GeneralInfo.where(id: user_ids).where.not(userKey: user_key_current).order(updated_at: :desc) : nil
    @allusers = GeneralInfo.where.not(userKey: user_key_current)
    @loader = true

    @notifications_from = @user.notification_from if @user&.notification
  end

  def setup_chat(chat_id)
    @chatting_with = GeneralInfo.find_by(id: chat_id)
    return unless @chatting_with

    @chatname = @chatting_with[:first_name]
    @chatid = chat_id
    @chatlink = "/dm/#{@chatid}"

    @room_name = get_name(@user, @chatting_with)
    @single_room = Room.find_or_create_by(name: @room_name) do |room|
      Room.create_private_room([@user, @chatting_with], @room_name)
    end
    @room_id = @single_room[:id]

    @messages = Message.where(room_id: @room_id).order(:created_at)
    @loader = false
  end

  def handle_notifications
    return unless @user.notification

    @new_notification_from = @notifications_from.reject { |n| n == @chatid.to_i }
    @user.update(notification: @new_notification_from.any?, notification_from: @new_notification_from)
  end

  def fetch_general_info(user_key_current)
    return unless GeneralInfo.exists?(userKey: user_key_current)

    @gallery = Gallery.all
    @general_info = GeneralInfo.find_by(userKey: user_key_current)
    return unless @general_info

    @general_info_attributes = @general_info.attribute_names
    @general_info_values = @general_info.attribute_values
    @login_info = LoginInfo.find_by(userKey: user_key_current)
    @username = @general_info[:first_name]
  end

  def create_new_message(chat_id, body, files)
    @chatting_with = GeneralInfo.find_by(id: chat_id)
    return unless @chatting_with

    @chatlink = "/dm/#{chat_id}"
    @room_name = get_name(@user, @chatting_with)
    @single_room = Room.find_or_create_by(name: @room_name) do |room|
      Room.create_private_room([@user, @chatting_with], @room_name)
    end

    @message = Message.create(general_info_id: @user[:id], room_id: @single_room[:id], body: body, chatting_with: chat_id)
    @message.files.attach(files) if files.present?

    redirect_to @chatlink
  end

  def get_name(user1, user2)
    user = [user1.id, user2.id].sort
    "private_#{user[0]}_#{user[1]}"
  end
end

