require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RoomsHelper. For example:
#
# describe RoomsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RoomsHelper, type: :helper do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "#format_room_number" do
    it "formats room number with leading zeros" do
      expect(helper.format_room_number(5)).to eq("Room 005")
    end

    it "handles double-digit room numbers" do
      expect(helper.format_room_number(42)).to eq("Room 042")
    end

    it "handles triple-digit room numbers" do
      expect(helper.format_room_number(100)).to eq("Room 100")
    end
  end

  describe "#room_capacity_label" do
    it "returns 'Small' for capacities up to 5" do
      expect(helper.room_capacity_label(3)).to eq("Small")
      expect(helper.room_capacity_label(5)).to eq("Small")
    end

    it "returns 'Medium' for capacities between 6 and 15" do
      expect(helper.room_capacity_label(6)).to eq("Medium")
      expect(helper.room_capacity_label(15)).to eq("Medium")
    end

    it "returns 'Large' for capacities above 15" do
      expect(helper.room_capacity_label(16)).to eq("Large")
      expect(helper.room_capacity_label(30)).to eq("Large")
    end
  end

  describe "#room_availability_status" do
    it "returns 'Available' for available rooms" do
      expect(helper.room_availability_status(true)).to eq("Available")
    end

    it "returns 'Occupied' for unavailable rooms" do
      expect(helper.room_availability_status(false)).to eq("Occupied")
    end
  end
end
