class InvitationMailer < ApplicationMailer
    def invitation_email(email,inviter_name,project_name,project_key)
      @url = login_url
      @inviter_name = inviter_name
      @invited_email = email
      @project_name = project_name
      @project_url = galleries_show_url(:project_key => project_key)
      mail(to: email, subject: 'You have been invited to collaborate on a project.')
    end
  end
  