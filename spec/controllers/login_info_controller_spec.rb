require "rails_helper"

RSpec.describe LoginInfoController, type: :controller do
  # still need updatedo

  describe "GET #new" do
    it "should create new LoginInfo" do
      @login_info = LoginInfo.new
      get :new, params: { id: @LoginInfo.to_param, template: 'login_info/new' }
      expect(response).to render_template :new
    end
    
    it "should not create new GeneralInfo" do
      @login_infos = LoginInfo.nil?
      get :new, params: { id: @LoginInfo.to_param, template: 'login_info/new' }
      expect(response).to render_template root_path
    end
  end
  
  describe "POST #create" do 
    it 'should create LoginInfo' do
      post :create, :login_info => { :email => "me@me.com", :password => "pass123" }
      expect(response).to redirect_to new_login_info_path
    end
    it 'should not create LoginInfo' do
      ### NEED TO FIX ###
      post :create, :login_info => { :email => "me@me.com", :password => "" }
      expect(response).to redirect_to new_login_info_path
    end
  end
  
  describe "GET #edit" do
    it "renders the edit template" do
      get :edit
      expect(response).to render_template(:edit)
      expect(response).to render_template("edit")
      expect(response).to render_template("login_info/edit")
    end

    it "does not render a different template" do
      get :edit
      expect(response).to_not render_template("login_info/new")
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
    
  describe "POST #update" do 
    it 'should update GeneralInfo' do
      # post :update, :login_info => {  :email => "rspec@spec.com",
      #                                 :password => "spec123",
      #                                 :password_confirmation => "spec123" }
      # expect(response).to redirect_to show_profile_show_profile_path
    end
    # it 'should not update GeneralInfo' do
    #   post :update, :general_info => { :first_name => "R", :last_name => "Spec", :month_ofbirth => 01, :day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "Colorado", :city => "Denver", :compensation => "Any", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 0}
    #   expect(response).to render :edit
    #   # assert.redirect_to new_general_info_path
    # end
  end
  
  describe "GET #login" do
    it "renders the login template" do
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
      @login_info = FactoryGirl.create(:login_info)
    end
    
    let(:attr) do 
      { :email => 'me@me.com', :password => 'pass123' }
    end
    
    before(:each) do
      post :login_submit, :login_info => attr
      @login_info.reload
    end
    
    it 'should successfully submit credentials for login' do
      expect(response).to redirect_to root_path
      expect(@login_info.email).to eql attr[:email] 
      expect(@login_info.password).to eql attr[:password] 
    end
    
    it 'should not successfully submit credentials for login' do
      ### NEED TO FIX THIS ###
      @login_info = LoginInfo.nil?
      expect(response).to redirect_to root_path
    end
  end
  
  describe "GET #logout" do
    it "renders the logout template" do
      get :logout
      expect(response).to redirect_to destroy_user_session_path
    end

    it "does not render a different template" do
      get :login
      expect(response).to_not render_template "login_info/edit" 
    end
  end
  
end
