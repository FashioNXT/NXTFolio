require "rails_helper"

RSpec.describe UnconfirmedUserController, type: :controller do
  let(:unconfirmed_user) { create(:unconfirmed_user) }
  let(:login_info) { create(:login_info) }

  describe "GET #new" do
    it "assigns a new unconfirmed user to @unconfirmed_user" do
      @unconfirmed_user = UnconfirmedUser.new
      get :new, params: { id: @unconfirmed_user.to_param, template: 'unconfirmed_user/new' }
      expect(response).to render_template :new
    end
  end

  describe "POST #verify" do
    let!(:unconfirmed_user) do
      UnconfirmedUser.create!(
        unconfirmed_email: 'test1@mail.com',
        encrypted_password: 'Test#123',
        confirmation_token: '123456',
        confirmation_sent_at: Time.current
      )
    end

    context "with valid token" do
      it "verifies the user and redirects to new_general_info_path" do
        post :verify, params: { unconfirmed_user: { confirmation_token: unconfirmed_user.confirmation_token } }
        expect(flash[:success]).to eq("You Have Successfully Verified your email!")
        expect(response).to redirect_to(new_general_info_path)
      end
    end

    context "with invalid token" do
      it "redirects to unconfirmed_user_new_path with error" do
        post :verify, params: { unconfirmed_user: { confirmation_token: "654321" } }
        expect(flash[:error]).to eq("Invalid token")
        expect(response).to redirect_to(unconfirmed_user_new_path)
      end
    end
  end

  describe "POST #regenerate_token" do
    context "when session is nil" do
      it "redirects to unconfirmed_user_new_path with error" do
        post :regenerate_token
        expect(flash[:error]).to eq("No session found. Please try signing-up again to resend the verification token!")
        expect(response).to redirect_to(unconfirmed_user_new_path)
      end
    end

    context "when user is not found" do
      it "redirects to unconfirmed_user_new_path with error" do
        session[:current_login_user] = { 'email' => 'nonexistent@example.com' }
        post :regenerate_token
        expect(flash[:error]).to eq("Invalid email. Please try signing-up again to resend the verification token!")
        expect(response).to redirect_to(unconfirmed_user_new_path)
      end
    end

    context "when user is found" do
      it "regenerates the token and sends email" do
        @unconfirmed_user = UnconfirmedUser.new
        session[:current_login_user] = { 'email' => 'test2@mail.com' }
        @unconfirmed_user = UnconfirmedUser.create!( unconfirmed_email: 'test2@mail.com', encrypted_password: 'Test#123', confirmation_token: '654321', confirmation_sent_at: Time.current)
        post :regenerate_token
        expect(flash[:notice]).to eq('We have sent you a new code to verify the email!')
        expect(response).to redirect_to(unconfirmed_user_new_path)
        @unconfirmed_user.destroy
      end
    end
  end
end