class UnconfirmedUserController < ApplicationController

  def new
    @unconfirmed_user = UnconfirmedUser.new
  end

  def verify
    @unconfirmed_user = UnconfirmedUser.new(unconfirmed_user_params)
    if not UnconfirmedUser.exists?(:confirmation_token => @unconfirmed_user[:confirmation_token])
      flash[:error] = "Invalid token"
      redirect_to unconfirmed_user_new_path and return
    end
    @user = UnconfirmedUser.find_by(confirmation_token: @unconfirmed_user[:confirmation_token])
    @login_info = LoginInfo.new
    @login_info.email = @user.unconfirmed_email
    @login_info.password = @user.encrypted_password
    session[:current_login_user] = @login_info
    @user.destroy
    flash[:success] = "You Have Successfully Verified your email!"
    redirect_to new_general_info_path
  end

  def regenerate_token
    if session[:current_login_user].nil?
      flash[:error] = "No session found. Please try signing-up again to resend the verification token!"
      redirect_to unconfirmed_user_new_path and return
    end
    @user = UnconfirmedUser.find_by(unconfirmed_email: session[:current_login_user]['email'])
    if @user.nil?
      flash[:error] = "Invalid email. Please try signing-up again to resend the verification token!"
      redirect_to unconfirmed_user_new_path and return
    end
    @user.confirmation_token = SecureRandom.random_number(1000000).to_s.rjust(6, '0')
    @user.confirmation_sent_at = Time.current
    @user.save
    EmailVerificationMailer.verification_email(@user).deliver_now!
    flash[:notice] = 'We have sent you a new code to verify the email!'
    redirect_to unconfirmed_user_new_path
  end

  def unconfirmed_user_params
    params.require(:unconfirmed_user).permit(:unconfirmed_email, :confirmation_token, :confirmation_sent_at, :encrypted_password)
  end
end