# spec/controllers/comments_controller_spec.rb

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User factory
  let(:portfolio) { create(:portfolio) } # Assuming you have a Portfolio factory

  context 'when commenting on a portfolio posting' do
    before { sign_in user }

    describe 'POST #create' do
      context 'with a non-empty comment' do
        it 'creates a comment' do
          expect {
            post :create, params: { portfolio_id: portfolio.id, comment: { body: 'Great work on this portfolio!' } }
          }.to change(Comment, :count).by(1)

          expect(flash[:notice]).to eq('Comment submitted successfully')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with an empty comment' do
        it 'does not create a comment' do
          expect {
            post :create, params: { portfolio_id: portfolio.id, comment: { body: '' } }
          }.not_to change(Comment, :count)

          expect(flash[:alert]).to eq('Comment cannot be empty')
          expect(response).to render_template('new') # Adjust this based on your implementation
        end
      end
    end
  end
end
