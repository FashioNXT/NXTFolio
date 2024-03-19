 require "rails_helper"

 RSpec.describe SpecificDesignerController, type: :controller do
#   # need update
  describe "GET #new" do
    it "should create new SpecificDesigner" do
      @specific_designer = SpecificDesigner.new
      get :new, params: { id: @SpecificDesigner.to_param, template: 'specific_designer/new' }
      expect(response).to render_template :new
    end

    it "should not create new SpecificDesigner" do
      @specific_designers = SpecificDesigner.nil?
      get :new, params: { id: @SpecificDesigner.to_param, template: 'specific_designer/new' }
      expect(response).to render_template root_path
    end
  end

  describe "POST #create" do 
    it 'should create SpecificDesigner' do
      post :create, params: {:specific_designer => { :influencers => "Me", :specialties => "Being cool", :compensation => "Any", :experience => "11+ years", :genre => "Acting" }}
      expect(response).to redirect_to show_profile_show_profile_path
    end
  end

  describe "GET #edit" do
    it "should get SpecificDesigner" do
      session[:current_user_key] = SecureRandom.hex(10)
      @specific_designer = SpecificDesigner.create(influencers: "Me", specialties: "Being cool", compensation: "Any", experience: "11+ years", genre: "Acting", user_key: session[:current_user_key])
      get :edit, params: { id: @SpecificDesigner.to_param, template: 'specific_designer/edit' }
    end

    it "should not get SpecificDesigner" do
      @specific_designer = SpecificDesigner.new
      get :edit, params: { id: @SpecificDesigner.to_param, template: 'specific_designer/edit' }
      expect(response).to redirect_to new_specific_designer_path
    end
  end

  describe "POST #update" do
    it "should update SpecificDesigner" do
      session[:current_user_key] = SecureRandom.hex(10)
      SpecificDesigner.create(influencers: "Me", specialties: "Being cool", compensation: "Any", experience: "11+ years", genre: "Acting", user_key: session[:current_user_key])
      post :update, params: { specific_designer: {:influencers => "Me", :specialties => "Being cool", :compensation => "$100,000", :experience => "11+ years", :genre => "Acting"}}
      expect(response).to redirect_to show_profile_show_profile_path
    end
  end 

  describe "DELETE #destroy" do
    it "should delete SpecificDesigner" do
      @specific_designer = SpecificDesigner.create(influencers: "Me", specialties: "Being cool", compensation: "Any", experience: "11+ years", genre: "Acting", user_key: SecureRandom.hex(10))
      delete :destroy, params: {user_key: @specific_designer.user_key}
      expect(response).to redirect_to root_path
    end
  end
  
 end
  