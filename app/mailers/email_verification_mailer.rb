class EmailVerificationMailer < ApplicationMailer
  def verification_email(user)
    @verificationToken = user
    @userL = user
    mail(to: @userL["email"], subject: 'Email Verification')
  end
end
