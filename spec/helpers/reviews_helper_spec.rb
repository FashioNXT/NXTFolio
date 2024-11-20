require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReviewsHelper. For example:
#
# describe ReviewsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReviewsHelper, type: :helper do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "#format_rating" do
    it "formats rating as stars" do
      expect(helper.format_rating(4)).to eq("★★★★☆")
    end

    it "handles zero rating" do
      expect(helper.format_rating(0)).to eq("☆☆☆☆☆")
    end

    it "handles full rating" do
      expect(helper.format_rating(5)).to eq("★★★★★")
    end
  end

  describe "#review_status_class" do
    it "returns 'positive' for ratings 4 and above" do
      expect(helper.review_status_class(4)).to eq("positive")
      expect(helper.review_status_class(5)).to eq("positive")
    end

    it "returns 'neutral' for rating 3" do
      expect(helper.review_status_class(3)).to eq("neutral")
    end

    it "returns 'negative' for ratings below 3" do
      expect(helper.review_status_class(2)).to eq("negative")
      expect(helper.review_status_class(1)).to eq("negative")
    end
  end

  
end
