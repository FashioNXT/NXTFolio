class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # facebook callback
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?

    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]

      redirect_to root_path #change to new_general_info_path for creating room profile
    end

    # check if room is in our DB or not
    # if not, add room to our DB
    # Then assign userKey
    #if LoginInfo.exists?(:email => @room[:email])
    #  @login_user = LoginInfo.find_by(email: @room[:email])
    #  userKey = @login_user.userKey
    #else #Else, Add room to the DB
    #New User is lead to general_info new page.
    #@login_user = LoginInfo.new(:email => @room[:email], :password => @room[:password], :password_confirmation => @room[:password])
    #userKey = SecureRandom.hex(10)
    #@login_user.userKey = userKey
    #if @login_user.save!
    #end
    #end
    #session[:current_user_key] = userKey
  end

  # google callback
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #overridden in application_controller.rb
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to root_path
    end

    # check if room is in our DB or not
    # if not, add room to our DB
    # Then assign userKey
    #if LoginInfo.exists?(:email => @room[:email])
    #  @login_user = LoginInfo.find_by(email: @room[:email])
    #  userKey = @login_user.userKey
    #else #Else, Add room to the DB
    #New User is lead to general_info new page.
    #@login_user = LoginInfo.new(:email => @room[:email], :password => @room[:password], :password_confirmation => @room[:password])
    #userKey = SecureRandom.hex(10)
    #@login_user.userKey = userKey
    #if @login_user.save!
    #end
    #end
    #session[:current_user_key] = userKey
  end

  def failure
    flash[:error] = 'Problem occured while signing you in. Please try again.'
    redirect_to root_path
  end
end
