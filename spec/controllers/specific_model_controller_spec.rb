require "rails_helper"

 RSpec.describe SpecificModelController, type: :controller do
#   # need update
  describe "GET #new" do
    it "should create new SpecificModel" do
      @specific_model = SpecificModel.new
      get :new, params: { id: @SpecificModel.to_param, template: 'specific_model/new' }
      expect(response).to render_template :new
    end

    it "should not create new SpecificModel" do
      @specific_models = SpecificModel.nil?
      get :new, params: { id: @SpecificModel.to_param, template: 'specific_model/new' }
      expect(response).to render_template root_path
    end
  end

  describe "POST #create" do 
    it 'should create SpecificModel' do
      post :create, params: {:specific_model => {:height_feet => 5, :height_inches => 5, :bust => 36, :waist => 24, :hips => 36, :cups => "C", :hair_color => "black", :eye_color => "brown", :ethnicity => "English", :skin_color => "white", :shoot_nudes => "no", :experience => "5 years"}}
      expect(response).to redirect_to show_profile_show_profile_path
    end
  end

  describe "GET #edit" do
    it "should get SpecificModel" do
      session[:current_user_key] = SecureRandom.hex(10)
      @specific_model = SpecificModel.create(height_feet: 5, height_inches: 5, bust: 36, waist: 24, hips: 36, cups: "C", hair_color: "black", eye_color: "brown", ethnicity: "English", skin_color: "white", shoot_nudes: "no", experience: "5 years", user_key: session[:current_user_key])
      get :edit, params: { id: @SpecificModel.to_param, template: 'specific_model/edit' }
    end

    it "should not get SpecificModel" do
      @specific_model = SpecificModel.new
      get :edit, params: { id: @SpecificModel.to_param, template: 'specific_model/edit' }
      expect(response).to redirect_to new_specific_model_path
    end
  end

  describe "POST #update" do
    it "should update SpecificModel" do
      session[:current_user_key] = SecureRandom.hex(10)
      SpecificModel.create(height_feet: 5, height_inches: 5, bust: 36, waist: 24, hips: 36, cups: "C", hair_color: "black", eye_color: "brown", ethnicity: "English", skin_color: "white", shoot_nudes: "no", experience: "5 years", user_key: session[:current_user_key])
      post :update, params: { specific_model: {:shoot_nudes => "yes"}}
      expect(response).to redirect_to show_profile_show_profile_path
    end
  end 

  describe "DELETE #destroy" do
    it "should delete SpecificModel" do
      @specific_model = SpecificModel.create(height_feet: 5, height_inches: 5, bust: 36, waist: 24, hips: 36, cups: "C", hair_color: "black", eye_color: "brown", ethnicity: "English", skin_color: "white", shoot_nudes: "no", experience: "5 years", user_key: SecureRandom.hex(10))
      delete :destroy, params: {user_key: @specific_model.user_key}
      expect(response).to redirect_to root_path
    end
  end
  
 end