class LoginInfoController < ApplicationController
  # Variable that holds a params/object with all the attributes filled in
  def list
    @login_infos = LoginInfo.all
  end

  def show
    @login_info = LoginInfo.find(params[:id])
  end

  # Associated with the view used for create
  def new
    @login_info = LoginInfo.new
  end

  # Create is called upon for the 1st part of profile creation
  def create
    @login_info = LoginInfo.new(login_info_params)
    if LoginInfo.exists?(:email => @login_info[:email])
      flash[:error] = "Email already exists."
      redirect_to login_info_new_path and return
    end

    # Checks for mismatched & unentered passwords before saving LoginInfo object to database
    # field value required in HTML, hence this check not required
    # unless @login_info[:password] != "" && login_info_params[:password_confirmation] != ""
    #   flash[:notice] = "Enter your password! Please try again."
    #   redirect_to login_info_login_path and return
    # end
    
    unless @login_info[:password] == login_info_params[:password_confirmation]
      #@login_info.userKey = SecureRandom.hex(10)
      flash[:error] = "Passwords don't match! Please try again."
      redirect_to login_info_new_path and return
    end

    unless @login_info.validate_pwd == true
      flash[:error] = "#{@login_info.errors.full_messages.first}"
      redirect_to login_info_new_path and return
    end
    # @unconfirmed_user.verification_email
    @user = UnconfirmedUser.find_by(unconfirmed_email: @login_info.email)
    if @user.present?
      flash[:notice] = 'We have already sent you a code to verify your email. Please check your inbox and spam!'
      redirect_to unconfirmed_user_new_path and return
    end
    UnconfirmedUser.create!(
      unconfirmed_email: @login_info.email,
      encrypted_password: @login_info.password,
      confirmation_token: SecureRandom.random_number(1000000).to_s.rjust(6, '0'),
      confirmation_sent_at: Time.current
    )
    
    EmailVerificationMailer.verification_email(UnconfirmedUser.last).deliver_now!
    session[:current_login_user] = @login_info
    redirect_to unconfirmed_user_new_path, notice: 'We have sent you a new code to verify the email. Please verify your email and continue your registration!'
  end

  # Params used to create the LoginInfo object
  def login_info_params
    params.require(:login_info).permit(:email, :password, :password_confirmation)
    # params.require(:sign_in_up).permit(:email, :password, :password_confirmation)
  end

  # Allows room to edit the login_info_params of the LoginInfo object
  # Displays information pulled from database that matches the session key of the current room
  # Associated with the view used for update
  def edit
    if LoginInfo.exists?(:userKey => session[:current_user_key])
      @login_info = LoginInfo.find_by(userKey: session[:current_user_key])
    end
  end

  # Saves the edit of the LoginInfo object to the database
  def update
    @login_info = LoginInfo.find_by(userKey: session[:current_user_key])

    if login_info_params[:password] == login_info_params[:password_confirmation]
      # if @login_info.update_attributes(login_info_params)
      if @login_info.update(login_info_params)
        redirect_to '/show_profile'
      else
        render :action => 'edit'
      end
    else
      flash[:error] = "Passwords don't match!"
      render :action => 'edit'
    end
  end

  # Not implemented   
  def delete
  end

  # Associated with the view used for login_submit
  def login
    @login_info = LoginInfo.new
    #render :template => :'new/login'
  end

  # Checks the email & password input against existing LoginInfo objects in database
  # Sets the session key of the current room if match found
  # Else displays error message
  def login_submit
    @login_info = LoginInfo.new(login_info_param)
    if LoginInfo.exists?(:email => @login_info[:email])
      @login_user = LoginInfo.find_by(email: @login_info[:email])
      
      if @login_user[:password] == @login_info[:password]
        #login

        if not @login_user[:enabled]
          flash[:notice] = 'This accound is currently disabled'
          redirect_to login_info_login_path
        else
          session[:current_user_key] = @login_user[:userKey]
          session[:login_time] = Time.current # Spring 2023

          if @login_user[:is_admin] != nil
            session[:is_admin] = true
          end
          flash[:success] = "You Have Successfully Logged In! Welcome Back!"

          # create/update record in the user_activity_details table
          current_user = GeneralInfo.find_or_create_by(userKey: session[:current_user_key])
          redirect_to root_path
        end
      else
        flash[:error] = "The Credentials You Provided Are Not Valid. Please Try Again."
        redirect_to login_info_login_path
      end
    else
      flash[:error] = "The Credentials You Provided Are Not Valid. Please Try Again."
      # redirect_to login_info_login_path
      redirect_to login_info_login_path
    end
  end

  # Params used to find the LoginInfo object in the database
  def login_info_param
    params.require(:login_info).permit(:email, :password)
  end

  # Removes the session key of the current room
  def logout
    session[:current_user_key] = nil
    session[:is_admin] = false
    session.delete(:login_time)
    flash[:success] = "You Have Successfully Logged Out! Hope To See You Soon!"
    $current_user = nil #for facebook login usecase
    # redirect_to destroy_user_session_path
    redirect_to destroy_user_session_path
  end
end
