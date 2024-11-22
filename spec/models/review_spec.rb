require 'rails_helper'

RSpec.describe Review, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:general_info) { GeneralInfo.create(first_name: "John", last_name: "Doe", company: "Test Co", industry: "Tech", highlights: ["Test"], country: "USA", state: "CA", city: "SF", emailaddr: "john@example.com") }
  let(:gallery) { Gallery.create(gallery_title: "Test Gallery", gallery_description: "Test Description", gallery_picture: ["test.jpg"], GeneralInfo_id: general_info.id) }

  describe "associations" do
    it "belongs to a general_info" do
      association = described_class.reflect_on_association(:general_info)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a gallery" do
      association = described_class.reflect_on_association(:gallery)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe "validations" do
    # it "is valid with valid attributes" do
    #   review = Review.new(rating: 5, general_info: general_info, gallery_id: gallery.id)
    #   expect(review).to be_valid
    # end

    it "is not valid without a rating" do
      review = Review.new(general_info: general_info, gallery_id: gallery.id)
      expect(review).to_not be_valid
    end

    it "is not valid without a gallery_id" do
      review = Review.new(rating: 5, general_info: general_info)
      expect(review).to_not be_valid
    end
  end

  describe "scopes" do
    before do
      @review1 = Review.create(rating: 4, general_info: general_info, gallery_id: gallery.id, created_at: 2.days.ago)
      @review2 = Review.create(rating: 5, general_info: general_info, gallery_id: gallery.id, created_at: 1.day.ago)
    end

    # it "orders reviews by most recent first" do
    #   expect(Review.order(created_at: :desc)).to eq([@review2, @review1])
    # end
  end
end
