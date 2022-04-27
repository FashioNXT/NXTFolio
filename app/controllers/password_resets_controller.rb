class PasswordResetsController < ApplicationController
  def new
  end

  def create

    @testing=LoginInfo.all
    @exusers=LoginInfo.find_by(email: params[:email])


    if @exusers.present?
      #send email
      # Need to set it as background job
      logger.info("Present Test: Hemooon")
      #logger.debug(@token.inspect)
      ForgotMailer.reset(@exusers).deliver_now
    else
      #logger.info("Not Present! Yahooo!")
    end

    redirect_to root_path, :notice => "If an account exists with this email, We have sent a link to reset the password"

  end

  def edit
    @exusers=GlobalID::Locator.locate_signed(params[:token], purpose: "password reset")
    if @exusers.nil?
      logger.info("Link is invalid")
      redirect_to root_path, :notice => "The Password Reset Link is Expired! Please Try Again"
    else
      logger.info("Link is valid")
    end

  end

  def update
    @exusers=GlobalID::Locator.locate_signed(params[:token], purpose: "password reset")
    logger.info("Tracking Exusers")
    logger.debug(params[:token].inspect)

    if @exusers.update(password_params)
      logger.info("Yay!")
      redirect_to root_path, :notice => "Your Password has been reset Successfully!"
    else
      redirect_to :edit
    end
  end

  def password_params
    params.require(:exusers).permit(:password,:password_confirmation)
  end

end
