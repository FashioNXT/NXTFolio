require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe "get_similar_galleries" do
    it 'gets similar galleries to the user\'s' do
      general_info_1 = GeneralInfo.create(:first_name => "Robert", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Male", :country => "United States", :state => "TX", :city => "Houston")
      general_info_2 = GeneralInfo.create(:first_name => "Roberta", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston")
      gallery_1 = Gallery.create(GeneralInfo_id: general_info_1.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg')])
      gallery_2 = Gallery.create(GeneralInfo_id: general_info_2.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('3.jpg', 'image/jpg'), fixture_file_upload('4.jpg', 'image/jpg')])
      gallery_3 = Gallery.create(GeneralInfo_id: general_info_2.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('5.jpg', 'image/jpg'), fixture_file_upload('6.jpg', 'image/jpg')])
      tag_1 = Tag.create(gallery_id: gallery_1.id, body: "Test")
      tag_2 = Tag.create(gallery_id: gallery_2.id, body: "Test")
      similar_galleries = gallery_1.get_similar_galleries
      expect(similar_galleries.keys[0]).to eq(gallery_2)
    end
  end
end
