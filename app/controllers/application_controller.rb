class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Used to confirm the session key of the current user
  def index
    @landing = true
    @users = GeneralInfo.order(updated_at: :desc).limit(20)
    if session[:current_user_key]
      current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
      @username = current_user[:first_name]
    end
    #To display DB, delete this later!
    @login_infos = LoginInfo.all
    @general_infos = GeneralInfo.all

  end

  # Enables redirection to general_info new page after sign in
  # by overriding sign_in_and_redirect in omniauth_callbacks controller
  def after_sign_in_path_for(resource)

    @user = resource
    if LoginInfo.exists?(:email => @user[:email]) #For existing user
      @login_user = LoginInfo.find_by(email: @user[:email])
      userKey = @login_user.userKey
      session[:current_user_key] = userKey
      super #redirect to where the user came from
    else
      @user[:password]+="#1a" #for password requirement
      session[:current_login_user]=@user
      new_general_info_path
    end
  end
end
