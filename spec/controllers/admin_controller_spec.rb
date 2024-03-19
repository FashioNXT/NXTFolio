require 'rails_helper'

RSpec.describe Admin::AdminController, type: :controller do
    before do
        GeneralInfo.delete_Job('Test_job')
        GeneralInfo.delete_Job('Test')
    end
    describe "GET#landing" do
        it "should redirect to the login page for non-admins" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", userKey: session[:current_user_key], is_admin: false)
            get :landing
            expect(response).to redirect_to login_info_login_path
        end
    end

    describe "GET#create" do
        it "should create a new job" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", job_name: "Test", userKey: session[:current_user_key])
            get :create, params: {job_name: "test job"}
            expect(flash.now[:notice]).to eq("Test Job has been created.\nCurrent jobs are : " + GeneralInfo.see_Jobs.join(","))
            GeneralInfo.delete_Job("Test_job")
        end

        it "should not create a new job if it already exists" do
            GeneralInfo.create_Job("test")
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", userKey: session[:current_user_key])
            get :create, params: {job_name: "test"}
            expect(flash.now[:notice]).to eq("Test already exists.\nCurrent jobs are : " + GeneralInfo.see_Jobs.join(","))
            GeneralInfo.delete_Job("Test")
        end

        it "should not create a new job if it is empty" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", userKey: session[:current_user_key])
            get :create, params: {job_name: ""}
        end
    end

    describe "GET#delete" do
        it "deletes a job" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", job_name: "Test", userKey: session[:current_user_key], is_admin: true)
            GeneralInfo.create_Job("test")
            get :delete, params: {job_name: "test"}
            expect(flash.now[:notice]).to eq("test".titleize + " has been deleted.")
        end

        it "redirects to login page if user is not admin" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", job_name: "Test", userKey: session[:current_user_key], is_admin: false)
            get :delete
            expect(response).to redirect_to login_info_login_path
        end
    end
end 