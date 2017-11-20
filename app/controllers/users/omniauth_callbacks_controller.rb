class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    params[:email]='me@me.com'
    params[:password]='password'
    @login_info_controller=LoginInfoController.new
    @login_info_controller.login
    @login_info_controller.login_info[:email]='me@me.com'
    @login_info_controller.login_info[:password]='password'
    @login_info_controller.login_submit

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end