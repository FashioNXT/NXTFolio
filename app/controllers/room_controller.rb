class RoomController < ApplicationController
  def show
    if session[:current_user_key] != nil or params[:user_key] != nil

      user_key_current = params[:user_key] || session[:current_user_key]
      @error = user_key_current.to_s
      puts "sessions current_user_key" + user_key_current.to_s

      @user = GeneralInfo.find_by(userKey: user_key_current)
      user_ids = Message.where("general_info_id = ? OR chatting_with = ?", @user[:id], @user[:id])
          .pluck(:general_info_id, :chatting_with)
          .flatten
          .uniq

      @users = user_ids.present? ? GeneralInfo.where(id: user_ids).where.not(userKey: user_key_current).order(updated_at: :desc) : nil
      @allusers = GeneralInfo.where.not(userKey: user_key_current)
      @loader = true

      if @user && @user.notification
        @notifications_from = @user.notification_from
      end

      if params[:id]
        @chatting_with = GeneralInfo.find_by(id: params[:id])
        @chatname = @chatting_with[:first_name]
        @chatid = params[:id]
        @chatlink = "/dm/" + @chatid

        @room = Room.new
        @room_name = get_name(@user, @chatting_with)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @chatting_with], @room_name)
        @room_id = @single_room[:id]

        @messages = Message.where(room_id: @room_id).order(created_at: :asc)
        @loader = false
        
        if @user.notification
          @new_notification_from = []

          @notifications_from.each do |n|
            if n != @chatid.to_i
              @new_notification_from.append(n)
            end
          end

          if @new_notification_from.length() == 0
            @user.notification = false
          end
          
          @notifications_from = @new_notification_from
          @user.notification_from = @new_notification_from

          @user.save
        end
      end

      if GeneralInfo.exists?(:userKey => user_key_current)
        @gallery = Gallery.all
        @general_info = GeneralInfo.find_by(userKey: user_key_current)
        @general_info_attributes = GeneralInfo.attribute_names
        @general_info_values = @general_info.attribute_values
        @login_info = LoginInfo.find_by(userKey: user_key_current)
        if LoginInfo.find_by(userKey: @general_info.userKey)
          @email = LoginInfo.find_by(userKey: @general_info.userKey).email
        end
        #@adminMaker = GeneralInfo.make_admin(params[:room])
        using_default = false

        if session[:current_user_key] != nil and params[:user_key] == nil
          @login_user_true = session[:current_user_key]
        end

        @username = @general_info[:first_name]
      end
    else
      redirect_to "/login_info/login"
    end
  end

  def create_message
    if session[:current_user_key] != nil or params[:user_key] != nil

      user_key_current = params[:user_key] || session[:current_user_key]
      @error = user_key_current.to_s
      puts "sessions current_user_key" + user_key_current.to_s

      @user = GeneralInfo.find_by(userKey: user_key_current)

      if params[:id]
        @chatting_with = GeneralInfo.find_by(id: params[:id])
        @chatname = @chatting_with[:first_name]
        @chatid = params[:id]
        @chatlink = "/dm/" + @chatid

        @room = Room.new
        @room_name = get_name(@user, @chatting_with)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @chatting_with], @room_name)

        @message = Message.create(general_info_id: @user[:id], room_id: @single_room[:id], body: params[:body], chatting_with: @chatid)
        # Check if there are any files in params[:files] and attach them
        if params[:files].present?
          @message.files.attach(params[:files])
        end
      end

      redirect_to @chatlink
    else
      redirect_to "/login_info/login"
    end
  end


  def index
    @messages = Message.where(room_id: params[:room_id])

    respond_to do |format|
      format.json do
        html = render_to_string(partial: 'room/messages', collection: @messages, as: :message, locals: { user: @user })
        render json: { html: html }
      end
    end
  end

  #def show_notifications
    
  #end

  private
  def get_name(user1, user2)
    user = [user1.id, user2.id].sort
    "private_#{user[0]}_#{user[1]}"
  end
end
