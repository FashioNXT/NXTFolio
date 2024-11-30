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
      expect(response).to render_template :edit2
    end
    
    it "should not create new GeneralInfo" do
      @general_infos = GeneralInfo.nil?
      get :new2, params: { id: @GeneralInfo.to_param, template: 'general_info/new2' }
      expect(response).to render_template root_path
    end
  end

  describe "GET #make_admin" do 
  it 'should create an admin when there is an existing admin user' do
    # Set up an existing admin user in the session
    @general_info = GeneralInfo.create(
      first_name: "R",
      last_name: "Spec",
      highlights: "test highlights",
      company: "test company",
      industry: "test industry",
      emailaddr: "test@gmail.com",
      phone: 892,
      month_ofbirth: 1,
      day_ofbirth: 31,
      year_ofbirth: 1985,
      gender: "Female",
      country: "United States",
      state: "TX",
      city: "Denver",
      compensation: "Any Payment",
      facebook_link: "www.fb.com/rspec",
      linkedIn_link: "www.li.com/rspec",
      instagram_link: "www.ig.com/rspec",
      personalWebsite_link: "www.rspec.com",
      bio: "I'm RSpec",
      specific_profile_id: 2,
      userKey: SecureRandom.hex(10),
      is_admin: true
    )
  
    # Set the current user in the session to the admin user
    session[:current_user_key] = @general_info.userKey
  
    # Create a new user to be promoted to admin
    new_user = GeneralInfo.create(
      first_name: "New",
      last_name: "User",
      highlights: "new user highlights",
      company: "new company",
      industry: "new industry",
      emailaddr: "new_user@gmail.com",
      phone: 123,
      month_ofbirth: 2,
      day_ofbirth: 15,
      year_ofbirth: 1990,
      gender: "Male",
      country: "United States",
      state: "TX",
      city: "Austin",
      compensation: "Any",
      userKey: SecureRandom.hex(10)
    )
  
    # Call the `make_admin` action to promote the new user
    get :make_admin, params: { user: new_user.userKey }
  
    # Expect a redirect to the show profile path for the new user
    expect(response).to redirect_to(show_profile_show_profile_path(user_key: new_user.userKey))
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
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Asdf@123"}
      post :create, params: { :general_info => {:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2}}
      expect(response).to have_http_status(:no_content)
      session.delete(:current_login_user)
    end

    it 'should not create GeneralInfo' do
      session[:current_login_user] = {"password" => "Asdf@123"}
      post :create, params: { :general_info => { :first_name => "", :last_name => "", :highlights => "", :company => "", :industry => "", :job_name => "", :emailaddr => "test@gmail.com", :month_ofbirth => 01, :day_ofbirth => 31,:phone =>892, :year_ofbirth => 1985, :gender => "Female", :country => "", :state => "", :city => "", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 0}}
      expect(response).to render_template :new
      session.delete(:current_login_user)
    end

    it 'should not create an admin user if there already exists a user' do 
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Asdf@123"}
      @general_info = GeneralInfo.create(:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2, :is_admin => true)
      post :create, params: { :general_info => {:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :job_name => "admin", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2}}
      session.delete(:current_login_user)
    end

    it 'should show the second user creation page' do 
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Asdf@123"}
      post :create, params: { select_one: true,  :general_info => {:first_name => "R", :last_name => "Spec", :highlights => "test highlights", :company => "test company", :industry => "test industry", :emailaddr => "test@gmail.com", :phone =>892, :month_ofbirth => 01,:day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "TX", :city => "Denver", :compensation => "Any Payment", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 2}}
      expect(response).to redirect_to general_info_new2_path
    end

    it 'should show the search engine' do 
      session[:current_login_user] = {"email" => "test@gmail.com", "password" => "Asdf@123"}
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

  describe "GET#Generate about me" do
      user = GeneralInfo.create!(
        first_name: "user",
        last_name: "testing",
        city: "College Station",
        state: "Texas",
        country: "United States",
        emailaddr: "user@example.com",
        company: "VisualTech",
        gender: "Male",
        industry: "Photography",
        specialization: "Portraits",
        highlights: "none",
        userKey: SecureRandom.hex(10)
      )

      before do
        session[:current_user_key] = user.userKey
      end

      it 'creates response based on general info' do
        # Mock AboutMeGenerator to avoid real API calls
        about_me_double = instance_double("AboutMeGenerator")
        allow(AboutMeGenerator).to receive(:new).and_return(about_me_double)
        allow(about_me_double).to receive(:generate_about_me).and_return("Generated about me content.")
        allow(about_me_double).to receive(:missing_fields).and_return([])

        get :generate_about_me
        json = JSON.parse(response.body)
        
        expect(json).to have_key('about_me')
        expect(json['about_me']).to eq("Generated about me content.")
      end

      it 'includes missing fields in the response when fields are incomplete' do
        # Mock AboutMeGenerator and the missing_fields method
        about_me_double = instance_double("AboutMeGenerator")
        allow(AboutMeGenerator).to receive(:new).and_return(about_me_double)
        allow(about_me_double).to receive(:generate_about_me).and_return("Generated about me content.")
        allow(about_me_double).to receive(:missing_fields).and_return(['city', 'industry'])
    
        get :generate_about_me
        json = JSON.parse(response.body)
    
        expect(json['missing_fields']).to eq(['city', 'industry'])
      end
    
      it 'returns an error if user is not found' do
        # Set an invalid user key
        session[:current_user_key] = 'invalid_key'

        # Added mocking to prevent api call being made in testing if  error function changes
        about_me_double = instance_double("AboutMeGenerator")
        allow(AboutMeGenerator).to receive(:new).and_return(about_me_double)
        allow(about_me_double).to receive(:generate_about_me).and_return("Generated about me content.")
        allow(about_me_double).to receive(:missing_fields).and_return([])
    
        get :generate_about_me
        expect(response).to have_http_status(:not_found)
      end   
  end
end