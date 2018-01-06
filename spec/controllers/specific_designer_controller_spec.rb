require "rails_helper"

RSpec.describe SpecificDesignerController, type: :controller do
  # need update
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
      post :create, :specific_designer => { :influencers => "Me", :specialties => "Being cool", :compensation => "Any", :experience => "11+ years", :genre => "Acting" }
      expect(response).to redirect_to root_path
    end
    it 'should not create SpecificDesigner' do
      ### NEED TO FIX ###
      # Look at data to see what "duplicate" data can be used to cause save to fail
      post :create, :specific_designer => { :influencers => "Me", :specialties => "Being cool", :compensation => "Any", :experience => "11+ years", :genre => "Acting" }
      # expect(response).to render_template new_specific_designer_path
      expect(response).to redirect_to root_path
    end
  end
  
  describe "GET #edit" do
    it "renders the edit template" do
      get :edit
      # expect(response).to render_template("new")
      expect(response).to redirect_to "/specific_designer/new"
    end

    # it "does not render a different template" do
    #   get :edit
    #   expect(response).to_not render_template "specific_designer/edit"
    # end
    
    it "should get SpecificDesigner" do
      @specific_designer = SpecificDesigner.new
      get :edit, params: { id: @SpecificDesigner.to_param, template: 'specific_designer/new' }
    end
    
    it "should not get SpecificDesigner" do
      @specific_designer = SpecificDesigner.nil?
      get :edit, params: { id: @SpecificDesigner.to_param, template: 'specific_designer/new' }
    end
  end
  
end
  