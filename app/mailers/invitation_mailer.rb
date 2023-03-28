class InvitationMailer < ApplicationMailer
    def invitation_email(email)
      @url = login_url # change this to the URL of your registration page
      mail(to: email, subject: 'You have been invited to collaborate on a project.')
    end
  end
  