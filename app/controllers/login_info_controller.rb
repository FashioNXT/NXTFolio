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
      flash[:notice] = "Email already exists."
      redirect_to root_path and return
    end

    # Checks for mismatched & unentered passwords before saving LoginInfo object to database
    unless @login_info[:password] != "" && login_info_params[:password_confirmation] != ""
      flash[:notice] = "Enter your password! Please try again."
      redirect_to login_info_login_path and return
    end
    
    unless @login_info[:password] == login_info_params[:password_confirmation]
      #@login_info.userKey = SecureRandom.hex(10)
      flash[:notice] = "Passwords don't match! Please try again."
      redirect_to login_info_login_path and return
    end

    unless @login_info.validate_pwd == true
      flash[:notice] = "Failed Saving beause Email/Password format is not valid !"
      redirect_to login_info_login_path and return
    end

    #session[:current_user_key] = @login_info.userKey
    #flash[:notice] = "Account Created!"

    session[:current_login_user]=@login_info
    redirect_to new_general_info_path
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
      flash[:notice] = "Passwords don't match!"
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
        session[:current_user_key] = @login_user[:userKey]

        if @login_user[:is_admin] != nil
          session[:is_admin] = true
        end
        flash[:success] = "You Have Successfully Logged In! Welcome Back!";
        redirect_to root_path
      else
        flash[:notice] = "The Credentials You Provided Are Not Valid. Please Try Again."
        redirect_to login_info_login_path
      end
    else
      flash[:notice] = "The Credentials You Provided Are Not Valid. Please Try Again."
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
    flash[:success] = "You Have Successfully Logged Out! Hope To See You Soon!"
    $current_user = nil #for facebook login usecase
    # redirect_to destroy_user_session_path
    redirect_to destroy_user_session_path
  end
end
