require 'rails_helper'

feature 'Sign up with Facebook' do

  before do
    #OmniAuth.config.add_mock(:google_oauth2, {:uid => '12345'})

    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

  end

  let(:user) { create(:user) }

  scenario 'with valid email and password' do
    visit root_path
    click_on "sign in"
    click_on "Facebook"
    expect(current_path).to eql(new_general_info_path)
  end
end
