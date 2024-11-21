require 'rails_helper'

RSpec.describe Room, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it "is valid with valid attributes" do
      room = Room.new(name: "Test Room")
      expect(room).to be_valid
    end

    it "is valid with a unique name" do
      room = Room.new(name: "Unique Room")
      expect(room).to be_valid
    end

    it "is not valid with a duplicate name" do
      Room.create(name: "Test Room")
      room = Room.new(name: "Test Room")
      expect(room).to_not be_valid
    end
  end

  describe "associations" do
    it "has many messages" do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq :has_many
    end
  end

  describe "scopes" do
    it "returns public rooms" do
      public_room = Room.create(name: "Public Room", is_private: false)
      private_room = Room.create(name: "Private Room", is_private: true)
      expect(Room.public_rooms).to include(public_room)
      expect(Room.public_rooms).not_to include(private_room)
    end
  end

  describe ".create_private_room" do
    it "creates a private room with the given name" do
      users = [double("User"), double("User")]
      room = Room.create_private_room(users, "Private Chat")
      expect(room.name).to eq("Private Chat")
      expect(room).to be_persisted
    end
  end
end
