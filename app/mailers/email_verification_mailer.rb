class EmailVerificationMailer < ApplicationMailer
  def verification_email(user)
    @verificationToken = user.confirmation_token
    @userL = user
    mail(to: @userL["unconfirmed_email"], subject: 'Email Verification')
  end
end
