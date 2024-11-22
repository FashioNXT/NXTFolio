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

  describe "#truncate_message" do
      it "truncates long messages" do
        long_message = "This is a very long message that needs to be truncated"
        expect(helper.truncate_message(long_message, 20)).to eq("This is a very lo...")
      end

      it "doesn't truncate short messages" do
        short_message = "Short message"
        expect(helper.truncate_message(short_message, 20)).to eq("Short message")
      end

      it "handles messages exactly at the truncation length" do
        exact_message = "This is twenty char"
        expect(helper.truncate_message(exact_message, 20)).to eq("This is twenty char")
      end

  end

  describe "#message_status_class" do
    it "returns 'unread' for unread messages" do
      expect(helper.message_status_class(false)).to eq("unread")
    end

    it "returns 'read' for read messages" do
      expect(helper.message_status_class(true)).to eq("read")
    end
  end
end
