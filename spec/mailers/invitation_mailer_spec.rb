require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "invitation_email" do
    let(:inviter) { User.create(name: "John Doe", email: "john@example.com") }
    let(:invitee_email) { "jane@example.com" }
    let(:project_name) { "Test Project" }
    let(:project_key) { "test_key_123" }
    let(:mail) { InvitationMailer.invitation_email(invitee_email, "Jane Doe", inviter.name, project_name, project_key) }

    it "renders the headers" do
      expect(mail.subject).to eq("You have been invited to collaborate on a project.")
      expect(mail.to).to eq([invitee_email])
      expect(mail.from).to eq(["fashionxtllc@gmail.com"]) # Updated to match your actual 'from' email
    end

    
  end
end
