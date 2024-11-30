require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "invitation_email" do
    let(:inviter) { GeneralInfo.create(first_name: "John", last_name: "Doe", email: "john@example.com") }
    let(:invitee_email) { "jane@example.com" }
    let(:project_name) { "Test Project" }
    let(:project_key) { "test_key_123" }
    let(:mail) { InvitationMailer.invitation_email(invitee_email, "Jane Doe", inviter.first_name, project_name, project_key) }

    it "renders the headers" do
      expect(mail.subject).to eq("You have been invited to collaborate on a project.")
      expect(mail.to).to eq([invitee_email])
      expect(mail.from).to eq(["fashionxtllc@gmail.com"]) # Updated to match your actual 'from' email
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Jane Doe")
      expect(mail.body.encoded).to match(inviter.first_name)
      expect(mail.body.encoded).to match(project_name)
    end

    it "includes the invitation link" do
      expect(mail.body.encoded).to include("galleries/show?id=#{project_key}")
    end
  end
end
