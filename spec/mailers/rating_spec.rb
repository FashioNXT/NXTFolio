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

    
  end
end
