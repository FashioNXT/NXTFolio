require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RoomHelper. For example:
#
# describe RoomHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RoomHelper, type: :helper do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "#format_room_name" do
    it "capitalizes the first letter of each word" do
      expect(helper.format_room_name("living room")).to eq("Living Room")
    end

    it "handles single-word room names" do
      expect(helper.format_room_name("kitchen")).to eq("Kitchen")
    end

    it "trims leading and trailing whitespace" do
      expect(helper.format_room_name("  bedroom  ")).to eq("Bedroom")
    end
  end  


end
