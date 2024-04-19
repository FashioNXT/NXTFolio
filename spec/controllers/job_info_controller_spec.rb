require 'rails_helper'

RSpec.describe JobInfoController, type: :controller do
    describe "GET#index" do
        it 'should get the job info of the current user' do
            session[:current_user_key] = SecureRandom.hex(10)
            get :index, params: {template: 'job_info/index'}
        end 
    end

    describe "GET#search" do
        it 'should search the job info when keyword is present in tile and description' do
            JobInfo.create(country: "United States", state: "California", city: "San Jose", profession: "Designer", category: "Creators", title: "test", description: "test")
            get :search, params: {Country: "United States", State: "California", City: "San Jose", Profession: "Designer", Category: "Creators", Keyword: "test"}
        end
        
        it 'should search the job info when keyword is not present in title or description' do
            JobInfo.create(country: "United States", state: "California", city: "San Jose", profession: "Designer", category: "Creators", title: "test", description: "test")
            get :search, params: {Country: "United States", State: "California", City: "San Jose", Profession: "Designer", Category: "Creators", Keyword: "Test"}
        end 

        it 'should search the job info when keyword is not present in title or description' do
            JobInfo.create(country: "United States", state: "California", city: "San Jose", profession: "Designer", category: "Creators", title: "test", description: "test")
            get :search, params: {Country: "United States", State: "California", City: "San Jose", Profession: "Designer", Category: "Creators"}
        end
    end
    
    describe "GET#show" do
        it 'should show the job' do
            job_info = JobInfo.create(country: "United States", state: "California", city: "San Jose", profession: "Designer", category: "Creators", title: "test", description: "test")
            get :show, params: {id: job_info.id}
            expect(response).to render_template :show
        end 
    end

    describe "GET#visitor_show" do
        it 'should show the job to a visitor' do
            job_info = JobInfo.create(country: "United States", state: "California", city: "San Jose", profession: "Designer", category: "Creators", title: "test", description: "test")
            get :visitor_show, params: {id: job_info.id}
            expect(response).to render_template :visitor_show
        end 
    end

    describe "GET#new_job" do
        it 'should create a new job' do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key])
            get :new_job
        end
    end

    describe "POST#post_job" do
        it 'should post a new job' do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", job_name: "Designer", userKey: session[:current_user_key])
            post :post_job, params: {job_info: {country: "United States", state: "California", city: "San Jose", profession: "Designer", category: "Creators", title: "test", description: "test"}}
            expect(response).to redirect_to job_search_jobshow_path
        end 

        it 'should not post a new job' do
            post :post_job, params: {job_info: {country: "United States", state: "California", city: "San Jose"}}
            expect(response).to render_template :new_job
        end 
    end

    describe "GET#destroy" do
        it 'should destroy a job' do
            job_info = JobInfo.create(country: "United States", state: "California", city: "San Jose", profession: "Designer", category: "Creators", title: "test", description: "test")
            get :destroy, params: {id: job_info.id}
            expect(response).to redirect_to "/job_info"
        end
    end

end 