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

        context 'with invalid parameters' do
            it 'does not create a new user and re-renders new' do
                expect {
                    post :create, params: { user: user_params.merge(password_confirmation: 'WrongPassword') }
                }.not_to change(User, :count)
                expect(response).to render_template(:new)
            end
    
            it 'sets flash error messages' do
                post :create, params: { user: user_params.merge(password_confirmation: 'WrongPassword') }
                expect(flash[:error]).to be_present
            end
        end

        context 'with an already registered email' do
            before { User.create!(user_params) }
    
            it 'does not create a new user and re-renders new' do
                expect {
                    post :create, params: { user: user_params }
                }.not_to change(User, :count)
                expect(response).to render_template(:new)
            end
    
            it 'sets a flash error for duplicate email' do
                post :create, params: { user: user_params }
                expect(flash[:error]).to eq('Email has already been taken')
            end
        end

        context 'when the user is invalid and save is not invoked' do
            before do
              # Simulate validation failure by making the user invalid
              allow_any_instance_of(User).to receive(:valid?).and_return(false)
            end
          
            it 'does not create a new user' do
              expect {
                post :create, params: { user: user_params }
              }.not_to change(User, :count)
            end
          
            it 're-renders the new template' do
              post :create, params: { user: user_params }
              expect(response).to render_template(:new)
            end
          
            it 'sets flash error messages' do
              post :create, params: { user: user_params }
              expect(flash[:error]).to be_present
            end
          end
    end
end
