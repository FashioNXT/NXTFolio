require 'rails_helper'

RSpec.describe Admin::AdminController, type: :controller do
    before do
        GeneralInfo.delete_Job("Test")
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
            get :create, params: {job_name: "test"}
            expect(flash.now[:notice]).to eq("Test has been created.\nCurrent jobs are : " + GeneralInfo.see_Jobs.join(","))
            GeneralInfo.delete_Job("Test")
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

    describe "POST#edit" do
        it "should redirect to the login page for non-admins" do
            #session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", is_admin: false)
            post :edit
            expect(response).to redirect_to login_info_login_path
        end

        it "should add new attribute to the job" do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create_Job("test_job")
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", job_name: "Test_job", userKey: session[:current_user_key], is_admin: true)
            post :edit, params: {job_name: "test job", attr_action: "Add", attr_name: "test attribute"}
            expect(general_info[:job_attr]).to_not eq(nil)
            GeneralInfo.delete_Job("Test_job")
        end

        it "should not add new attribute to the job if it already exists" do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create_Job("Test")
            test_obj = Object.const_get("Test")
            test_obj.add_Attr("test_attribute")
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", userKey: session[:current_user_key], is_admin: true)
            post :edit, params: {job_name: "Test", attr_action: "Add", attr_name: "test_attribute"}
            expect(flash[:notice]).to eq("Attribute test_attribute already in Test---Test's current attributes are " + test_obj.view_Attr.inspect)
            GeneralInfo.delete_Job("Test")
        end
            
        it "should remove an attribute from the job" do
            session[:current_user_key] = SecureRandom.hex(10)
            GeneralInfo.create_Job("Test")
            test_obj = Object.const_get("Test")
            test_obj.add_Attr("test_attribute")
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", job_name: "Test", job_attr: {0 => "test_attribute"}, userKey: session[:current_user_key], is_admin: true)
            post :edit, params: {job_name: "Test", attr_action: "Remove", attr_name: "test_attribute"}
            expect(test_obj.view_Attr_Type('test_attribute')).to eq(nil)
            GeneralInfo.delete_Job("Test")
        end

        it "should post an error if the job you are trying to update doesn't exist" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", userKey: session[:current_user_key], is_admin: true)
            post :edit, params: {job_name: "test job", attr_action: "Add", attr_name: "test attribute"}
            expect(flash[:notice]).to eq("Job Test Job not found.")
        end

        it "should post an error message when any update fields are empty" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Houston", userKey: session[:current_user_key], is_admin: true)
            post :edit
            expect(flash[:notice]).to eq("Error: One or more empty fields")
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