require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
    before do
        session[:current_user_key] = SecureRandom.hex(10)
        @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
        @gallery = Gallery.create(GeneralInfo_id: @general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture: [fixture_file_upload('1.jpg', 'image/jpg')])
    end

    describe "GET#new" do
        it 'should make a new Review' do
            get :new, params: {gallery_id: @gallery.id}
        end
    end

    describe "POST#create" do
        it 'should create a new review' do
            post :create, params: {gallery_id: @gallery.id, review: {rating: 5, comments: "Test review"}}
            expect(response).to redirect_to show_profile_show_profile_path(:user_key => @general_info.userKey)
        end

        it 'should not create a new review' do
            post :create, params: {gallery_id: @gallery.id, review: {comments: "Test review"}}
            expect(response).to render_template :new
        end
    end

    describe "PUT#update" do
        it 'should update the review' do
            Review.create(rating: 5, comments: "Test review", user_id: @general_info.id, general_info_id: @general_info.id, gallery_id: @gallery.id)
            put :update, params: {id: Review.find_by_gallery_id(@gallery.id), gallery_id: @gallery.id, review: {rating: 4, comments: "Test review"}}
            expect(response).to redirect_to show_profile_show_profile_path(:user_key => @general_info.userKey)
        end

        it 'should not update the review' do
            Review.create(rating: 5, comments: "Test review", user_id: @general_info.id, general_info_id: @general_info.id, gallery_id: @gallery.id)
            put :update, params: {id: Review.find_by_gallery_id(@gallery.id), gallery_id: @gallery.id, review: {rating: nil}}
            expect(response).to render_template :edit
        end
    end
end
