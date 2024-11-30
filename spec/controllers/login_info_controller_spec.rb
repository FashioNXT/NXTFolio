require "rails_helper"

RSpec.describe LoginInfoController, type: :controller do
#   # still need updatedo

    describe "GET #new" do
        it "should create new LoginInfo" do
            @login_info = LoginInfo.new
            get :new, params: { id: @LoginInfo.to_param, template: 'login_info/new' }
            expect(response).to render_template :new
        end

        it "should not create new GeneralInfo" do
            @login_infos = LoginInfo.nil?
            get :new, params: { id: @LoginInfo.to_param, template: 'login_info/new' }
            expect(response).to render_template root_path
        end
    end
  
   describe "POST #create" do 
        it 'should create LoginInfo' do
            post :create, params: {:login_info => { :email => "me@me.com", :password => "Apple12345*", :password_confirmation => "Apple12345*" }}
            expect(response).to redirect_to unconfirmed_user_new_path
        end

        it 'should not create LoginInfo if email already exists' do
            @login_info = LoginInfo.create!(email: "me@me.com", password: "Asdf@123")
            post :create, params: {:login_info => { :email => "me@me.com", :password => "Apple12345*", :password_confirmation => "Apple12345*" }}
            expect(response).to redirect_to login_info_new_path
        end

        it 'should not create LoginInfo if passwords do not match' do
            post :create, params: {:login_info => { :email => "me@me.com", :password => "Apple12345*", :password_confirmation => "Orange12345*" }}
            expect(response).to redirect_to login_info_new_path
        end

        it 'should not create LoginInfo if password does not meet requirements' do
            post :create, params: {:login_info => { :email => "me@me.com", :password => "test", :password_confirmation => "test" }}
            expect(response).to redirect_to login_info_new_path
        end

   end
  
    describe "GET #edit" do
        it 'should edit the login info parameters' do
            session[:current_user_key] = SecureRandom.hex(10)
            @login_info = LoginInfo.create!(email: "me@me.com", password: "Asdf@123", userKey: session[:current_user_key])
            get :edit, params: {id: LoginInfo.to_param, template: 'login_info/edit'}
        end
    end

    
    
    describe "POST #update" do 
        it 'should update LoginInfo' do
            session[:current_user_key] = SecureRandom.hex(10)
            LoginInfo.create(email: "rspec@spec.com", password: "Spec#123", userKey: session[:current_user_key])
            post :update, params: { login_info: {   :email => "rspec@spec.com",
                                                    :password => "Ceps#123",
                                                    :password_confirmation => "Ceps#123" }}
            expect(response).to redirect_to show_profile_show_profile_path
        end

        it 'should not update LoginInfo' do
            session[:current_user_key] = SecureRandom.hex(10)
            LoginInfo.create(email: "rspec@spec.com", password: "Spec#123", userKey: session[:current_user_key])
            post :update, params: { login_info: {   :email => "rspec@spec.com",
                                                    :password => "spec#123",
                                                    :password_confirmation => "spec#123" }}
            expect(response).to render_template :edit
        end

        it 'should not update LoginInfo when passwords do not match' do
            session[:current_user_key] = SecureRandom.hex(10)
            LoginInfo.create(email: "rspec@spec.com", password: "Spec#123", userKey: session[:current_user_key])
            post :update, params: { login_info: {   :email => "rspec@spec.com",
                                                    :password => "spec#123",
                                                    :password_confirmation => "ceps#123" }}
            expect(response).to render_template :edit
        end
    end
    
    describe "GET #login" do
        it "renders the login template" do
            get :login
            expect(response).to render_template :login
        end

        it "does not render a different template" do
            get :login
            expect(response).to_not render_template "login_info/edit" 
        end
    end
  
    describe "POST #login_submit" do 
        it 'should successfully submit credentials for login for an ordinary user' do
            LoginInfo.create(email: 'me@me.com', password: 'Apple12345*', userKey: SecureRandom.hex(10))
            post :login_submit, params: { login_info: { email: 'me@me.com', password: 'Apple12345*' }}
            expect(flash[:success]).to eq("You Have Successfully Logged In! Welcome Back!")
            expect(response).to redirect_to root_path
        end

        it 'should should successfully submit credentials for login for an admin' do
            LoginInfo.create(email: 'me@me.com', password: 'Apple12345*', userKey: SecureRandom.hex(10), is_admin: true)
            post :login_submit, params: { login_info: { email: 'me@me.com', password: 'Apple12345*' }}
            expect(flash[:success]).to eq("You Have Successfully Logged In! Welcome Back!")
            expect(response).to redirect_to root_path
        end
    
        it 'should not successfully submit credentials for login when passwords do not match' do
            LoginInfo.create(email: 'me@me.com', password: 'Apple12345*', userKey: SecureRandom.hex(10), is_admin: true)
            post :login_submit, params: { login_info: { email: 'me@me.com', password: 'Orange12345*' }}
            expect(flash[:error]).to eq("The Credentials You Provided Are Not Valid. Please Try Again.")
            expect(response).to redirect_to login_info_login_path
        end

        it 'should not successfully submit credentials for login when user does not exist' do
            post :login_submit, params: { login_info: { email: 'me@me.com', password: 'Apple12345*' }}
            expect(flash[:error]).to eq("The Credentials You Provided Are Not Valid. Please Try Again.")
            expect(response).to redirect_to login_info_login_path
        end
   end
  
    describe "GET #logout" do
        it "renders the logout template" do
            get :logout
            expect(response).to redirect_to destroy_user_session_path
        end

        it "does not render a different template" do
            get :login
            expect(response).to_not render_template "login_info/edit" 
        end
    end
  
end
