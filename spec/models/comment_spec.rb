require 'rails_helper'

RSpec.describe Comment, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:general_info) do
    GeneralInfo.create(
      first_name: "John",
      last_name: "Doe",
      company: "Test Company",
      industry: "Test Industry",
      highlights: ["Test Highlight"],
      country: "USA",
      state: "California",
      city: "San Francisco",
      emailaddr: "john@example.com",
      job_name: "Designer"
    )
  end
  let(:gallery) do
    Gallery.create(
      gallery_title: "Test Gallery",
      gallery_description: "A test gallery description",
      gallery_picture: ["test.jpg"],
      GeneralInfo_id: general_info.id
    )
  end
  
  describe "validations" do
    it "is valid with valid attributes" do
      comment = Comment.new(body: "Great gallery!", gallery: gallery)
      expect(comment).to be_valid
    end

    it "is not valid without body" do
      comment = Comment.new(gallery: gallery)
      expect(comment).to_not be_valid
    end

    it "is not valid with body longer than 1000 characters" do
      comment = Comment.new(body: "a" * 1001, gallery: gallery)
      expect(comment).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a gallery" do
      association = described_class.reflect_on_association(:gallery)
      expect(association.macro).to eq :belongs_to
    end
  end

 

end
