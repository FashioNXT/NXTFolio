require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GalleryHelper. For example:
#
# describe GalleryHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GalleryHelper, type: :helper do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "#format_image_title" do
    it "capitalizes the first letter of each word" do
      expect(helper.format_image_title("sunset at beach")).to eq("Sunset At Beach")
    end

    it "handles single-word titles" do
      expect(helper.format_image_title("landscape")).to eq("Landscape")
    end

    it "trims leading and trailing whitespace" do
      expect(helper.format_image_title("  night sky  ")).to eq("Night Sky")
    end
  end

 
end
