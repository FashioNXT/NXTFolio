require "rails_helper"

RSpec.describe LoginInfoController, type: :controller do
  # list, login, login_submit, logout, edit, update
  
  # describe "GET #list" do
  #   it "should create list of LoginInfo" do
  #     @login_infos = LoginInfo.all
  #     get :list
  #     expect(response).to render_template root_path
  #   end
    
  #   it "should not create list of LoginInfo" do
  #     @login_infos = LoginInfo.nil?
  #     get :list
  #     expect(response).to render_template root_path
  #   end
  # end
  
  describe "GET #login" do
    it "renders the index template" do
      get :login
      expect(response).to render_template :login
    end

    it "does not render a different template" do
      get :login
      expect(response).to_not render_template "login_info/edit" 
    end
  end
  
  describe "POST #login_submit" do 
    before(:each) do
      @attr = { 
        login_info: {
          email: "me@me.com", 
          password: "pass123"
        }
      }
    end
    
    it 'should successfully submit credentials for login' do
      param = ActionController::Parameters.new(@attr)
      LoginInfo.create!(param.require(:login_info).permit!)
      
      post :create
      expect(response).to redirect_to new_specific_model_path
    end
    
    
    it 'should not successfully submit credentials for login' do
      param = ActionController::Parameters.new(@attr)
      LoginInfo.create!(param.require(:login_info).permit!)
      
      post :create
      expect(response).to redirect_to new_specific_model_path
    end
  end
  
  describe "GET #edit"
    it "renders the edit template" do
      get :edit
      expect(subject).to render_template(:edit)
      expect(subject).to render_template("edit")
      expect(subject).to render_template("login_info/edit")
    end

    it "does not render a different template" do
      get :edit
      expect(subject).to_not render_template("login_info/new")
    end
    
    it "should get LoginInfo" do
      @login_info = LoginInfo.new
      get :edit, params: { id: @LoginInfo.to_param, template: 'login_info/new' }
    end
    
    it "should not get LoginInfo" do
      @login_info = LoginInfo.nil?
      get :edit, params: { id: @LoginInfo.to_param, template: 'login_info/new' }
    end
end
