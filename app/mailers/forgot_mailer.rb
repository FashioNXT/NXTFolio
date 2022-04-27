class ForgotMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.forgot_mailer.reset.subject
  #
  def reset(user)
    @token=user.to_signed_global_id(expires_in: 15.minutes, purpose: "password reset").to_s
    #logger.info("Token Checking")
    #logger.debug(@token.inspect)
    mail to: user.email
  end
end
