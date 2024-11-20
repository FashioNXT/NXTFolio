require "rails_helper"

RSpec.describe RatingMailer, type: :mailer do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "gallery_rating_email" do
    let(:email) { "owner@example.com" }
    let(:owner_name) { "Jane Smith" }
    let(:reviewer_name) { "John Doe" }
    let(:project_name) { "Summer Fashion Collection" }
    let(:rating) { 4 }
    let(:mail) { RatingMailer.gallery_rating_email(email, owner_name, reviewer_name, project_name, rating) }

    it "renders the headers" do
      expect(mail.subject).to eq('One of your projects has been rated')
      expect(mail.to).to eq([email])
      expect(mail.from).to eq(["fashionxtllc@gmail.com"]) # Adjust if your default from address is different
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(owner_name)
      expect(mail.body.encoded).to match(reviewer_name)
      expect(mail.body.encoded).to match(project_name)
      expect(mail.body.encoded).to include(rating.to_s)
    end

    it "uses the correct layout" do
      expect(mail.body.encoded).to match(/<!DOCTYPE html>/)
      expect(mail.body.encoded).to match(/<html>/)
      expect(mail.body.encoded).to match(/<\/html>/)
    end
  end
end
