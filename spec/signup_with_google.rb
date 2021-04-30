require 'rails_helper'
#for duplicate initialization error, try commenting require "support/factory_girl.rb" in rails_helper.rb
feature 'Sign up with Google' do

  before do

    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]

  end

  let(:user) { create(:user) }

  scenario 'with valid email and password' do
    visit root_path
    click_on "sign in"
    click_on "Google"
    expect(current_path).to eql(new_general_info_path)

    visit new_general_info_path
    fill_in "first_name", :with => 'Dave'
    fill_in "last_name", :with => 'Wilson'
    select 'Jan', from: GeneralInfo.new["month_ofbirth"]
    select '01', from: GeneralInfo.new["day_ofbirth"]
    select '2000', from: GeneralInfo.new["year_ofbirth"]
    select 'Male', from: GeneralInfo.new["gender"]
    select 'US', from: GeneralInfo.new["country"]
    select 'TX', from: GeneralInfo.new["state"]
    fill_in "city", :with => 'College Station'
    fill_in "phone", :with => '010512'
    select 'Designer', from: GeneralInfo.new["job_name"]
    select 'Any', from: GeneralInfo.new["compensation"]
    click_on 'SAVE AND CONTINUE TO PROFESSION DETAIL PAGE'

  end
end
