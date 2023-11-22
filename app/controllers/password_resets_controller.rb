class PasswordResetsController < ApplicationController
  def new
  end

  def create


    exusers=LoginInfo.find_by(email: params[:email])


    if exusers.present?
      #send email
      # Need to set it as background job
      #logger.debug(@token.inspect)
      puts("here")
      ForgotMailer.reset(exusers).deliver_now
    else
      #logger.info("Not Present! Yahooo!")
    end

    redirect_to root_path, :notice => "If an account exists with this email, We have sent a link to reset the password"

  end

  def edit
    @exusers=GlobalID::Locator.locate_signed(params[:token], purpose: "password reset")
    logger.debug(@exusers.inspect)
    if @exusers.nil?
      logger.info("Link is invalid")
      redirect_to root_path, :notice => "The Password Reset Link is Expired! Please Try Again"
    else
      logger.info("Link is valid")
    end

  end

  def update


    @exusers=GlobalID::Locator.locate_signed(params[:token], purpose: "password reset")
    logger.info("Debugging instance variables")
    logger.debug(@exusers.inspect)

    # if @exusers.update_attributes!(exusers_params)
    if @exusers.update!(exusers_params)
      logger.info("Yay!")
      redirect_to login_path, :notice => "Your Password has been reset Successfully!"
    else
      redirect_to :edit
    end
  end

  def exusers_params
    #params.require(@exusers).permit(:password)
    params.require(:login_info).permit(:email, :password)
  end

end
