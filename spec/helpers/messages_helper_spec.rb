require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MessagesHelper. For example:
#
# describe MessagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MessagesHelper, type: :helper do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "#format_message_time" do
    it "formats time to 12-hour format" do
      time = Time.new(2023, 11, 19, 14, 30, 0)
      expect(helper.format_message_time(time)).to eq("2:30 PM")
    end

    it "handles midnight correctly" do
      time = Time.new(2023, 11, 19, 0, 0, 0)
      expect(helper.format_message_time(time)).to eq("12:00 AM")
    end
  end

  
end
