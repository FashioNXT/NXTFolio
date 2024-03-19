require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
    describe 'GET #index' do
        it "updates the time the user spent on website" do
            session[:current_user_key] = SecureRandom.hex(10)
            session[:login_time] = Time.current
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
            UserActivityDetail.create(user_id: general_info.id, logged_in_at: session[:login_time], time_spent_on_website: 9000, last_active_at: Date.new(2024,3,8))
            get :index
        end

        it "starts tracking the time the new user spends on website" do
            session[:current_user_key] = SecureRandom.hex(10)
            session[:login_time] = Time.current
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
            get :index
        end 
    end
end