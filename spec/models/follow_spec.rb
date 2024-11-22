require 'rails_helper'

RSpec.describe Follow, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:follower) { GeneralInfo.create(first_name: "John", last_name: "Doe", company: "Test Co", industry: "Tech", highlights: ["Test"], country: "USA", state: "CA", city: "SF", emailaddr: "john@example.com") }
  let(:followee) { GeneralInfo.create(first_name: "Jane", last_name: "Smith", company: "Test Inc", industry: "Fashion", highlights: ["Test"], country: "USA", state: "NY", city: "NYC", emailaddr: "jane@example.com") }

  describe "associations" do
    it "belongs to a follower" do
      association = described_class.reflect_on_association(:follower)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a followee" do
      association = described_class.reflect_on_association(:followee)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      follow = Follow.new(follower: follower, followee: followee)
      expect(follow).to be_valid
    end

    it "is not valid without a follower" do
      follow = Follow.new(followee: followee)
      expect(follow).to_not be_valid
    end

    it "is not valid without a followee" do
      follow = Follow.new(follower: follower)
      expect(follow).to_not be_valid
    end
  end

  describe "follow functionality" do
    it "allows a user to follow another user" do
      expect { follower.follow(followee.id) }.to change { Follow.count }.by(1)
    end

    it "allows a user to unfollow another user" do
      follower.follow(followee.id)
      expect { follower.unfollow(followee.id) }.to change { Follow.count }.by(-1)
    end
  end
end
