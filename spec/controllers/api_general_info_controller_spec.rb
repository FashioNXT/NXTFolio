require 'rails_helper'

RSpec.describe Api::GeneralInfoController, type: :controller do
    describe "GET#index" do
        it 'should get the general info table and show the last access time if the user is not new' do
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Austin", userKey: SecureRandom.hex(10))
            LoginInfo.create(email: "test@gmail.com", password: "Test#1234", userKey: general_info.userKey)
            UserActivityDetail.create(user_id: general_info.id)
            get :index
        end

        it 'should get the general info table and not show the last access time if the user is new' do
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Austin", userKey: SecureRandom.hex(10))
            LoginInfo.create(email: "test@gmail.com", password: "Test#1234", userKey: general_info.userKey)
            get :index
        end
    end 
end 