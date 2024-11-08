require 'rails_helper'

RSpec.describe RoomController, type: :controller do

    describe "GET #show" do
        it "should show the chatroom" do
            session[:current_user_key] = SecureRandom.hex(10)
            LoginInfo.create(email: "test@test.com", password: "Test#9", userKey: session[:current_user_key])
            general_info = GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key], notification: true)
            general_info.notification_from = [general_info.id]
            get :show, params: {id: general_info.id}
            expect(response).to have_http_status(:success)
        end

        it "should show the chatroom with messages from a different user" do
            session[:current_user_key] = SecureRandom.hex(10)
            LoginInfo.create(email: "test@test.com", password: "Test#9", userKey: session[:current_user_key])
            general_info = GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key], notification: true, notification_from: [1])
            get :show, params: {id: general_info.id}
            expect(response).to have_http_status(:success)
        end

        it "doesn't return http success" do
            general_info = GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key])
            get :show
            expect(response).to redirect_to "/login_info/login"
        end
    end

    describe "GET #create_message" do
        it "should create a new chat message" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key])
            get :create_message, params: {id: general_info.id}
            expect(response).to redirect_to "/dm/" + general_info.id.to_s
        end

        it "should create a new file message" do
            session[:current_user_key] = SecureRandom.hex(10)
            general_info = GeneralInfo.create(first_name: "R", last_name: "Spec", company: "Test", industry: "Test", highlights: "test", country: "United States", state: "California", city: "San Jose", emailaddr: "test@gmail.com", userKey: session[:current_user_key])
            file = fixture_file_upload('test_file.txt', 'text/plain')
            post :create_message, params: { id: general_info.id, files: file }
            expect(response).to redirect_to "/dm/" + general_info.id.to_s
        end

        it "should not create a new chat message" do
            get :create_message, params: {id: 1}
            expect(response).to redirect_to login_info_login_path
        end
    end

end
