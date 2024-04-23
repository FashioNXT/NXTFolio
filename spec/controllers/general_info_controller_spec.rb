require 'rails_helper'

RSpec.describe GeneralInfoController, type: :controller do

  describe "GET #list" do
    it "should create list of GeneralInfo" do
      @general_infos = GeneralInfo.all
      get :list, params: { id: @GeneralInfo.to_param, template: 'general_info/list' }
      expect(response).to render_template :list
    end
    
    it "should not create list of GeneralInfo" do
      @general_infos = GeneralInfo.nil?
      get :list, params: { id: @GeneralInfo.to_param, template: 'general_info/list' }
      expect(response).to render_template root_path
    end
  end
  
  describe "GET #new" do
    it "should create new GeneralInfo" do
      @general_info = GeneralInfo.new
      get :new, params: { id: @GeneralInfo.to_param, template: 'general_info/new' }
      expect(response).to render_template :new
    end
    
    it "should not create new GeneralInfo" do
      @general_infos = GeneralInfo.nil?
      get :new, params: { id: @GeneralInfo.to_param, template: 'general_info/new' }
      expect(response).to render_template root_path
    end
  end

  describe "GET #new2" do
    it "should create new GeneralInfo" do
      @general_info = GeneralInfo.new
      get :new2, params: { id: @GeneralInfo.to_param, template: 'general_info/new2' }
      expect(response).to render_template :new2
    end
    
    it "should not create new GeneralInfo" do
      @general_infos = GeneralInfo.nil?
      get :new2, params: { id: @GeneralInfo.to_param, template: 'general_info/new2' }
      expect(response).to render_template root_path
    end
  end

  describe "GET #make_admin" do 
    it 'should create an admin when there is an existing admin user' do
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :userKey => SecureRandom.hex(10), :is_admin => true)
      session[:current_user_key] = @general_info.userKey
      get :make_admin, params: {id: @GeneralInfo.to_param, user: @general_info.userKey, template: 'admin/create' }
      expect(response).to redirect_to show_profile_show_profile_path + "?user_key=" + @general_info.userKey
    end

    it 'should not create an admin when there is no existing admin user' do
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :userKey => SecureRandom.hex(10), :is_admin => false)
      session[:current_user_key] = SecureRandom.hex(10)
      get :make_admin, params: {id: @GeneralInfo.to_param, user: session[:current_user_key], template: 'admin/create' }
      expect(response).to redirect_to root_path
    end 

    it 'should not create an admin' do
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :userKey => SecureRandom.hex(10), :is_admin => true)
      session[:current_user_key] = @general_info.userKey
      get :make_admin, params: {id: @GeneralInfo.to_param, user: SecureRandom.hex(10), template: 'admin/create' }
      expect(response).to redirect_to root_path
    end
  end

  describe "POST #create" do
    it 'should create GeneralInfo' do
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Test#1"}
      post :create, params: { :general_info => {:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2}}
      expect(response).to have_http_status(:no_content)
      session.delete(:current_login_user)
    end

    it 'should not create GeneralInfo' do
      session[:current_login_user] = {"password" => "Test#1"}
      post :create, params: { :general_info => { :first_name => "", :last_name => "", :highlights => "", :company => "", :industry => "", :job_name => "", :emailaddr => "test@gmail.com", :month_ofbirth => 01, :day_ofbirth => 31,:phone =>892, :year_ofbirth => 1985, :gender => "Female", :country => "", :state => "", :city => "", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 0}}
      expect(response).to render_template :new
      session.delete(:current_login_user)
    end

    it 'should not create an admin user if there already exists a user' do 
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Test#1"}
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :is_admin => true)
      post :create, params: { :general_info => {:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :job_name => "admin", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2}}
      session.delete(:current_login_user)
    end

    it 'should show the second user creation page' do 
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Test#1"}
      post :create, params: { select_one: true,  :general_info => {:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2}}
      expect(response).to redirect_to general_info_new2_path
    end

    it 'should show the search engine' do 
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Test#1"}
      post :create, params: { select_two: true,  :general_info => {:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2}}
      expect(response).to redirect_to search_engine_show_path
    end
  end

  describe "GET #edit" do
    it "should get GeneralInfo" do
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :userKey => SecureRandom.hex(10))
      session[:current_user_key] = @general_info.userKey
      get :edit, params: { id: @GeneralInfo.to_param, template: 'general_info/edit' }
      expect(response).to render_template :edit
      session.delete(:current_user_key)
    end

    it 'should not get GeneralInfo' do
      @general_info = GeneralInfo.new
      get :edit, params: { id: @GeneralInfo.to_param, template: 'general_info/edit' }
      expect(response).to redirect_to new_general_info_path
    end
  end

  describe "GET #edit2" do
    it "should get GeneralInfo" do
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :userKey => SecureRandom.hex(10))
      session[:current_user_key] = @general_info.userKey
      get :edit2, params: { id: @GeneralInfo.to_param, template: 'general_info/edit2' }
      expect(response).to render_template :edit2
      session.delete(:current_user_key)
    end

    it "should not get GeneralInfo" do
      @general_info = GeneralInfo.new
      get :edit2, params: { id: @GeneralInfo.to_param, template: 'general_info/edit2' }
      expect(response).to redirect_to new_general_info_path
    end
  end

  describe "GET #edit_travel" do
    it "should get GeneralInfo" do
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :userKey => SecureRandom.hex(10))
      session[:current_user_key] = @general_info.userKey
      get :edit_travel, params: { id: @GeneralInfo.to_param, template: 'general_info/edit_travel' }
      expect(response).to render_template :edit_travel
      session.delete(:current_user_key)
    end

    it "should not get GeneralInfo" do
      @general_info = GeneralInfo.new
      get :edit_travel, params: { id: @GeneralInfo.to_param, template: 'general_info/edit_travel' }
      expect(response).to redirect_to new_general_info_path
    end
  end

  describe "POST #update" do 
    it 'should update GeneralInfo' do
      @general_info = GeneralInfo.create!({
        :first_name => "R", 
        :last_name => "Spec", 
        :month_ofbirth => 01, 
        :day_ofbirth => 31, 
        :year_ofbirth => 1985, 
        :gender => "Female", 
        :country => "United States", 
        :state => "Colorado", 
        :city => "Denver", 
        :compensation => "Any", 
        :facebook_link => "www.fb.com/rspec", 
        :linkedIn_link => "www.li.com/rspec", 
        :instagram_link => "www.ig.com/rspec", 
        :personalWebsite_link => "www.rspec.com", 
        :bio => "I'm RSpec",
        company: "test company",
        industry: "test industry",
        highlights: "test highlights",
        emailaddr: "test@email.com"
      })
      
      post :update, params: { id: @GeneralInfo.to_param, general_info: { is_admin: true }, select_one: true }
      expect(response).to redirect_to show_profile_show_profile_path
    end

    it 'should not update GeneralInfo' do
      @general_info = GeneralInfo.create!({
        :first_name => "R", 
        :last_name => "Spec", 
        :month_ofbirth => 01, 
        :day_ofbirth => 31, 
        :year_ofbirth => 1985, 
        :gender => "Female", 
        :country => "United States", 
        :state => "Colorado", 
        :city => "Denver", 
        :compensation => "Any", 
        :facebook_link => "www.fb.com/rspec", 
        :linkedIn_link => "www.li.com/rspec", 
        :instagram_link => "www.ig.com/rspec", 
        :personalWebsite_link => "www.rspec.com", 
        :bio => "I'm RSpec",
        company: "test company",
        industry: "test industry",
        highlights: "test highlights",
        emailaddr: "test@email.com"
      })
      
      post :update, params: { id: @GeneralInfo.to_param, general_info: { highlights: "" }}
      expect(response).to render_template :edit
    end
  end

  describe "GET#follow" do
    it 'follows a user' do
      user1 = GeneralInfo.create!({
        :first_name => "Robert", 
        :last_name => "Spec", 
        :month_ofbirth => 01, 
        :day_ofbirth => 31, 
        :year_ofbirth => 1985, 
        :gender => "Female", 
        :country => "United States", 
        :state => "Colorado", 
        :city => "Denver", 
        :compensation => "Any", 
        :facebook_link => "www.fb.com/rspec", 
        :linkedIn_link => "www.li.com/rspec", 
        :instagram_link => "www.ig.com/rspec", 
        :personalWebsite_link => "www.rspec.com", 
        :bio => "I'm RSpec",
        company: "test company",
        industry: "test industry",
        highlights: "test highlights",
        emailaddr: "test@email.com",
        userKey: SecureRandom.hex(10)
      })
      user2 = GeneralInfo.create!({
        :first_name => "Roberta", 
        :last_name => "Spec", 
        :month_ofbirth => 01, 
        :day_ofbirth => 31, 
        :year_ofbirth => 1985, 
        :gender => "Male", 
        :country => "United States", 
        :state => "Colorado", 
        :city => "Denver", 
        :compensation => "Any", 
        :facebook_link => "www.fb.com/rspec", 
        :linkedIn_link => "www.li.com/rspec", 
        :instagram_link => "www.ig.com/rspec", 
        :personalWebsite_link => "www.rspec.com", 
        :bio => "I'm RSpec",
        company: "test company",
        industry: "test industry",
        highlights: "test highlights",
        emailaddr: "test@email.com",
        userKey: SecureRandom.hex(10)
      })
      session[:current_user_key] = user1.userKey
      get :follow, params:{id: user2.id}
      expect(response).to redirect_to show_profile_show_profile_path(:user_key => user2.userKey)
    end
  end

  describe "GET#unfollow" do
    it 'follows a user' do
      user1 = GeneralInfo.create!({
        :first_name => "Robert", 
        :last_name => "Spec", 
        :month_ofbirth => 01, 
        :day_ofbirth => 31, 
        :year_ofbirth => 1985, 
        :gender => "Female", 
        :country => "United States", 
        :state => "Colorado", 
        :city => "Denver", 
        :compensation => "Any", 
        :facebook_link => "www.fb.com/rspec", 
        :linkedIn_link => "www.li.com/rspec", 
        :instagram_link => "www.ig.com/rspec", 
        :personalWebsite_link => "www.rspec.com", 
        :bio => "I'm RSpec",
        company: "test company",
        industry: "test industry",
        highlights: "test highlights",
        emailaddr: "test@email.com",
        userKey: SecureRandom.hex(10)
      })
      user2 = GeneralInfo.create!({
        :first_name => "Roberta", 
        :last_name => "Spec", 
        :month_ofbirth => 01, 
        :day_ofbirth => 31, 
        :year_ofbirth => 1985, 
        :gender => "Male", 
        :country => "United States", 
        :state => "Colorado", 
        :city => "Denver", 
        :compensation => "Any", 
        :facebook_link => "www.fb.com/rspec", 
        :linkedIn_link => "www.li.com/rspec", 
        :instagram_link => "www.ig.com/rspec", 
        :personalWebsite_link => "www.rspec.com", 
        :bio => "I'm RSpec",
        company: "test company",
        industry: "test industry",
        highlights: "test highlights",
        emailaddr: "test@email.com",
        userKey: SecureRandom.hex(10)
      })
      user1.follow(user2.id)
      session[:current_user_key] = user1.userKey
      get :unfollow, params:{id: user2.id}
      expect(response).to redirect_to show_profile_show_profile_path(:user_key => user2.userKey)
    end
  end
end