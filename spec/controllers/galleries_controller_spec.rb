require 'rails_helper'

RSpec.describe GalleriesController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "should create a new gallery" do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
      post :create, params: { gallery: {GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture: [fixture_file_upload('background-creative.jpg', 'image/jpg')]}}
      expect(response).to redirect_to show_profile_show_profile_path
    end
    
    it "should not create a new gallery when there are no pictures" do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
      post :create, params: { gallery: {GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test"}}
      expect(response).to render_template :new
    end

    it "should not create a new gallery when there are too many pictures" do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
      post :create, params: { gallery: {GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture: [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg'), fixture_file_upload('4.jpg', 'image/jpg'), fixture_file_upload('5.jpg', 'image/jpg'), fixture_file_upload('6.jpg', 'image/jpg')]}}
      expect(response).to render_template :new
    end

    it "should not create a new gallery" do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
      post :create, params: { gallery: {GeneralInfo_id: 1, gallery_title: "test", gallery_picture: [fixture_file_upload('1.jpg', 'image/jpg')]}}
      expect(response).to render_template :new
    end

  end

  describe "POST #update" do
    it 'should update the gallery' do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture: [fixture_file_upload('1.jpg', 'image/jpg')])
      post :update, params: { id: gallery.id, gallery: {test_picture: [fixture_file_upload('2.jpg', 'image/jpg')]}}
      expect(response).to redirect_to gallery
    end 

    it 'should not update the gallery when there are no pictures' do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture: [fixture_file_upload('1.jpg', 'image/jpg')])
      post :update, params: {id: gallery.id, gallery: {gallery_description: "edit"}}
      expect(response).to redirect_to gallery
    end

    it 'should not update the gallery when update parameters are not valid' do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture: [fixture_file_upload('1.jpg', 'image/jpg')])
      post :update, params: {id: gallery.id, gallery: {gallery_picture: ["test"]}}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "should destroy a gallery" do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture: [fixture_file_upload('1.jpg', 'image/jpg')])
      get :destroy, params: {id: gallery.id}
      expect(response).to redirect_to galleries_path
    end
  end

  describe "GET #delete" do
    it "should delete a gallery image" do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg'), fixture_file_upload('4.jpg', 'image/jpg'), fixture_file_upload('5.jpg', 'image/jpg')])
      get :delete, params: {id: gallery.id, idx: "2"}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #transfer" do
    it "should add images to the gallery" do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')], test_picture: [fixture_file_upload('4.jpg', 'image/jpg'), fixture_file_upload('5.jpg', 'image/jpg')])
      get :transfer, params: {id: gallery.id}
    end 

    it "should not add images to the gallery if there would be more than 5 after adding them" do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')], test_picture: [fixture_file_upload('4.jpg', 'image/jpg'), fixture_file_upload('5.jpg', 'image/jpg'), fixture_file_upload('6.jpg', 'image/jpg')])
      get :transfer, params: {id: gallery.id}
      expect(flash[:error]).to eq('You can not have more than 5 images in a gallery!')
    end 

    it "should not add images to the gallery" do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      get :transfer, params: {id: gallery.id}
    end
  end

  describe "GET #show" do
    it "should show the gallery" do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      collaboration = Collaboration.create(general_info_id: general_info.id)
      get :show, params: {id: gallery.id}
      expect(response).to have_http_status(:success)
    end
    it "should calculate the average review" do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      Review.create(general_info_id: general_info.id, gallery_id: gallery.id, rating: 5.0)
      Review.create(general_info_id: general_info.id, gallery_id: gallery.id, rating: 3.0)
      get :show, params: {id: gallery.id}
    end 
  end

  describe "POST #create_tagging" do
    it "should create a tagging" do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test1@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Male", :country => "United States", :state => "TX", :city => "Houston", userKey: session[:current_user_key])
      general_info_2 = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test2@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Austin", userKey: session[:current_user_key])
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      get :create_tagging, params: {id: gallery.id, gallery_tagging: {tagged_user_id: general_info_2.id, invited_email: "test2@gmail.com"}}
      expect(response).to redirect_to show_profile_show_profile_path
    end
    it "should not create a tagging" do
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", userKey: session[:current_user_key])
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      get :create_tagging, params: {id: gallery.id, gallery_tagging: {tagged_user_id: 543}}
      expect(response).to redirect_to show_profile_show_profile_path
    end 
  end

  describe "POST #destroy_tagging" do
    it 'should destroy a tagging' do
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Male", :country => "United States", :state => "TX", :city => "Houston")
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      gallery_tagging = GalleryTagging.create(general_info_id: general_info.id, gallery_id: gallery.id)
      delete :destroy_tagging, params: {id: gallery_tagging.id, gallery_id: gallery.id}
      expect(flash[:notice]).to eq('Collaborator removed successfully')
      redirect_to gallery
    end
  end
  
  describe "GET #add_comment" do
    it "should get a comment" do
      gallery = Gallery.create(GeneralInfo_id: 1, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      get :add_comment, params: {id: gallery.id}
    end
  end

  describe "POST #post_comment" do
    it "should post a comment" do
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Male", :country => "United States", :state => "TX", :city => "Houston")
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      Comment.create(gallery_id: gallery.id)
      post :post_comment, params: {id: gallery.id, comment: {body: "Test comment"}}
      expect(flash[:notice]).to eq("Comment added successfully.")
      expect(response).to redirect_to gallery
    end 

    it "should not post a comment" do
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Male", :country => "United States", :state => "TX", :city => "Houston")
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      Comment.create(gallery_id: gallery.id)
      post :post_comment, params: {id: gallery.id, comment: {comment_by: "test"}}
      expect(flash[:error]).to eq("Comment cannot be empty.")
      expect(response).to redirect_to gallery
    end 
  end

  describe "POST #create_tag" do
    it 'should create a tag' do
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Male", :country => "United States", :state => "TX", :city => "Houston")
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      post :create_tag, params: {id: gallery.id, tag: {body: "Test tag"}}
      expect(response).to redirect_to gallery_path(gallery)
    end 

    it 'should not create a tag' do
      general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "testgmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Male", :country => "United States", :state => "TX", :city => "Houston")
      gallery = Gallery.create(GeneralInfo_id: general_info.id, gallery_title: "test", gallery_description: "test", gallery_picture:  [fixture_file_upload('1.jpg', 'image/jpg'), fixture_file_upload('2.jpg', 'image/jpg'), fixture_file_upload('3.jpg', 'image/jpg')])
      post :create_tag, params: {id: gallery.id, tag: {body: nil}}
      expect(response).to render_template :add_tag
    end 
  end 
end
