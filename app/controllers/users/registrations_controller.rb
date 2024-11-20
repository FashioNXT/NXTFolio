class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params) # Build the user object without saving

    if resource.valid?
      session[:temp_user_data] = resource.attributes.slice('email', 'encrypted_password') # Store the attributes temporarily
      redirect_to general_info_new_path
    else
      clean_up_passwords(resource)
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
