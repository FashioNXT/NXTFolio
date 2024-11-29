require 'rails_helper'

RSpec.describe Message, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:general_info) { GeneralInfo.create(first_name: "John", last_name: "Doe", company: "Test Co", industry: "Tech", highlights: ["Test"], country: "USA", state: "CA", city: "SF", emailaddr: "john@example.com") }
  let(:room) { Room.create(name: "Test Room") }

  describe "associations" do
    it "belongs to a general_info" do
      association = described_class.reflect_on_association(:general_info)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a room" do
      association = described_class.reflect_on_association(:room)
      expect(association.macro).to eq :belongs_to
    end

    it "has many attached files" do
      expect(Message.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      message = Message.new(body: "Hello", general_info: general_info, room: room, chatting_with: 2)
      expect(message).to be_valid
    end

    it "is not valid without a general_info" do
      message = Message.new(body: "Hello", room: room, chatting_with: 2)
      expect(message).to_not be_valid
    end

    it "is not valid without a room" do
      message = Message.new(body: "Hello", general_info: general_info, chatting_with: 2)
      expect(message).to_not be_valid
    end
  end

  describe "callbacks" do
    it "calls notify after create" do
      message = Message.new(body: "Hello", general_info: general_info, room: room, chatting_with: 2)
      expect(message).to receive(:notify)
      message.save
    end
  end

  describe "scopes" do
    before do
      @message1 = Message.create(body: "First message", general_info: general_info, room: room, chatting_with: 2, created_at: 2.days.ago)
      @message2 = Message.create(body: "Second message", general_info: general_info, room: room, chatting_with: 2, created_at: 1.day.ago)
    end

    it "orders messages by most recent first" do
      expect(Message.order(created_at: :desc)).to eq([@message2, @message1])
    end
  end
end
