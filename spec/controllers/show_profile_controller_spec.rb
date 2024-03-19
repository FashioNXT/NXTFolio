require 'rails_helper'

RSpec.describe ShowProfileController, type: :controller do
    describe "GET#show_profile" do
        it 'should display the profile' do
            session[:current_user_key] = SecureRandom.hex(10)
            LoginInfo.create(email: "test@test.com", password: "Test#9", userKey: session[:current_user_key])
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key], notification: true)
            get :show_profile 
        end

        it 'should not display the profile' do
            get :show_profile 
        end

        it 'should check job' do
            GeneralInfo.create_Job("Test")
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key], job_name: "Test", job_attr: {name: "Test"})
            get :show_profile
        end
    end
end
