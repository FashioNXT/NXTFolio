require 'rails_helper'

RSpec.describe Tag, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:general_info) { GeneralInfo.create(first_name: "John", last_name: "Doe", company: "Test Co", industry: "Tech", highlights: ["Test"], country: "USA", state: "CA", city: "SF", emailaddr: "john@example.com") }
  let(:gallery) { Gallery.create(gallery_title: "Test Gallery", gallery_description: "Test Description", gallery_picture: ["test.jpg"], GeneralInfo_id: general_info.id) }
  
  describe "validations" do
    it "is valid with valid attributes" do
      tag = Tag.new(body: "TestTag", gallery: gallery)
      expect(tag).to be_valid
    end

    it "is not valid without a body" do
      tag = Tag.new(gallery: gallery)
      expect(tag).to_not be_valid
    end

    it "is not valid without a gallery" do
      tag = Tag.new(body: "TestTag")
      expect(tag).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a gallery" do
      association = described_class.reflect_on_association(:gallery)
      expect(association.macro).to eq :belongs_to
    end
  end
end
