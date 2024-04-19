class InvitationMailer < ApplicationMailer
    def invitation_email(email,invited_name,inviter_name,project_name,project_key)
      @invited_name = invited_name
      @inviter_name = inviter_name
      @invited_email = email
      @project_name = project_name
      @project_url = galleries_show_url(:id => project_key)
      mail(to: email, subject: 'You have been invited to collaborate on a project.')
    end
  end
  