require 'rails_helper'

RSpec.describe JobSearchController, type: :controller do
    describe "GET#jobshow" do
        it 'should show jobs' do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key])
            get :jobshow 
        end 
    end
end