require 'rails_helper'

RSpec.describe SearchEngineController, type: :controller do
    describe 'GET#show' do
        it 'should show the search engine' do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key])
            get :show
        end

        it 'should search' do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", job_name: "Designer", userKey: session[:current_user_key])
            get :search, params: {Country: "United States", State: "California", City: "San Jose", Profession: "Designer", Keyword: "Key"}
        end

        it 'should not search' do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", job_name: "Designer", userKey: session[:current_user_key])
            get :search
            expect(response).to render_template "search_engine/show"
        end
    end
end