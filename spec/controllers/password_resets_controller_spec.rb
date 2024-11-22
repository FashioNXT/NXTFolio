require 'rails_helper' 

RSpec.describe PasswordResetsController, type: :controller do
    describe "POST#create" do
        it "should send an email to reset password" do
            LoginInfo.create(email: "test@gmail.com", password: "Asdf@123")
            post :create, params: {email: "test@gmail.com"}
            expect(response).to redirect_to root_path
        end
    end

    describe "GET#edit" do
        it "should tell you the link is valid" do
            login_info = LoginInfo.create(email: "test@gmail.com", password: "Asdf@123")
            get :edit, params: {token: login_info.to_signed_global_id}
            expect(flash[:notice]).to eq("Link is valid")
        end

        it "should tell you the link is valid" do
            get :edit
            expect(flash[:alert]).to eq("Link is invalid")
        end
    end

    describe "PATCH#update" do
        it "should update the password" do
            login_info = LoginInfo.create(email: "test@gmail.com", password: "Asdf@123")
            patch :update, params: {token: login_info.to_signed_global_id, login_info: {password: "Asdf@123asd"}}
            expect(flash[:notice]).to eq("Your Password has been reset Successfully!")
            expect(response).to redirect_to login_path
        end

        it "should not update the passsword" do
            login_info = LoginInfo.create(email: "test@gmail.com", password: "Asdf@123")
            patch :update, params: {token: login_info.to_signed_global_id, login_info: {password: "Test"}}
            expect(response).to redirect_to "password_resets#edit"
        end
    end
end