class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :update_last_active_at
  before_action :track_time_spent_on_website

  # Used to confirm the session key of the current room
  def index
    @landing = true
    @users = GeneralInfo.order(updated_at: :desc).limit(40)
    #@users = GeneralInfo.paginate(page: params[:page], per_page: 12).order('updated_at DESC')
    #@users = GeneralInfo.paginate(page: params[:page], per_page: 12)
    #@users= GeneralInfo.left_joins(:reviews).paginate(page: params[:page], per_page: 12)
    respond_to do |format|
      format.html
      format.js
    end

    @gallery = Gallery.joins(:reviews).group(:id).paginate(page: params[:page], per_page: 12).order('avg(reviews.rating) DESC')

    if session[:current_user_key]
      current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
      if current_user
        @username = current_user[:first_name]
        @user_id=current_user[:general_info_id]
      end
    end
    #To display DB, delete this later!
    @login_infos = LoginInfo.all
    @general_infos = GeneralInfo.all

  end

  # Enables redirection to general_info new page after sign in
  # by overriding sign_in_and_redirect in omniauth_callbacks controller
  def after_sign_in_path_for(resource)

    @user = resource
    if LoginInfo.exists?(:email => @user[:email]) #For existing room
      @login_user = LoginInfo.find_by(email: @user[:email])
      userKey = @login_user.userKey
      session[:current_user_key] = userKey
      super #redirect to where the room came from
    else
      @user[:password]+="#1a" #for password requirement
      session[:current_login_user]=@user
      new_general_info_path
    end
  end

  private
begin
  def track_time_spent_on_website
    if session[:current_user_key]
      current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
      if current_user
        user_activity_detail = UserActivityDetail.find_or_create_by(user_id: current_user[:id], logged_in_at: session[:login_time])
        if user_activity_detail.time_spent_on_website.nil?
          user_activity_detail.update(
            logged_in_at: session[:login_time],
            last_active_at: Time.current,
            time_spent_on_website: 0
          )
        else
          time_spent = Time.current - user_activity_detail.last_active_at
          user_activity_detail.update(
            last_active_at: Time.current,
            time_spent_on_website: user_activity_detail.time_spent_on_website + time_spent.to_i
          )
        end
      end
    end
  end
end

end
