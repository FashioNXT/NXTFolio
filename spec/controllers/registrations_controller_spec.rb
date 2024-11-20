require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers  

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user] # Setup Devise mapping
  end

  describe 'GET #new' do
    subject { get :new }

    it 'renders the new template' do
      subject
      expect(response).to render_template(:new)
    end

    it 'responds with a 200 status code' do
      subject
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:user_params) { { email: 'test@example.com', password: 'Test1234!', password_confirmation: 'Test1234!' } }

    context 'with valid parameters' do
      subject { post :create, params: { user: user_params } }

      it 'does not save the user to the database yet' do
        expect { subject }.not_to change(User, :count)
      end

      it 'redirects to the general_info/new path' do
        subject
        expect(response).to redirect_to(general_info_new_path)
      end
    end
  end
end
