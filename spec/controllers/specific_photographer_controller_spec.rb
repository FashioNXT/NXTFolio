require "rails_helper"

RSpec.describe SpecificPhotographerController, type: :controller do
#   # need update
 describe "GET #new" do
   it "should create new SpecificPhotographer" do
     @specific_photographer = SpecificPhotographer.new
     get :new, params: { id: @SpecificPhotographer.to_param, template: 'specific_photographer/new' }
     expect(response).to render_template :new
   end

   it "should not create new SpecificPhotographer" do
     @specific_photographers = SpecificPhotographer.nil?
     get :new, params: { id: @SpecificPhotographer.to_param, template: 'specific_photographer/new' }
     expect(response).to render_template root_path
   end
 end

 describe "POST #create" do 
   it 'should create SpecificPhotographer' do
     post :create, params: {:specific_photographer => { :influencers => "Me", :specialties => "Being cool", :compensation => "Any", :experience => "11+ years", :genre => "Acting" }}
     expect(response).to redirect_to show_profile_show_profile_path
   end
 end

 describe "GET #edit" do
   it "should get SpecificPhotographer" do
     session[:current_user_key] = SecureRandom.hex(10)
     @specific_photographer = SpecificPhotographer.create(influencers: "Me", specialties: "Being cool", compensation: "Any", experience: "11+ years", genre: "Acting", user_key: session[:current_user_key])
     get :edit, params: { id: @SpecificPhotographer.to_param, template: 'specific_photographer/edit' }
   end

   it "should not get SpecificPhotographer" do
     @specific_photographer = SpecificPhotographer.new
     get :edit, params: { id: @SpecificPhotographer.to_param, template: 'specific_photographer/edit' }
     expect(response).to redirect_to new_specific_photographer_path
   end
 end

 describe "POST #update" do
   it "should update SpecificPhotographer" do
     session[:current_user_key] = SecureRandom.hex(10)
     SpecificPhotographer.create(influencers: "Me", specialties: "Being cool", compensation: "Any", experience: "11+ years", genre: "Acting", user_key: session[:current_user_key])
     post :update, params: { specific_photographer: {:influencers => "Me", :specialties => "Being cool", :compensation => "$100,000", :experience => "11+ years", :genre => "Acting"}}
     expect(response).to redirect_to show_profile_show_profile_path
   end
 end 

 describe "DELETE #destroy" do
   it "should delete SpecificPhotographer" do
     @specific_photographer = SpecificPhotographer.create(influencers: "Me", specialties: "Being cool", compensation: "Any", experience: "11+ years", genre: "Acting", user_key: SecureRandom.hex(10))
     delete :destroy, params: {user_key: @specific_photographer.user_key}
     expect(response).to redirect_to root_path
   end
 end
 
end
 