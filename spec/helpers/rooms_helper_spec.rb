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

 
end
