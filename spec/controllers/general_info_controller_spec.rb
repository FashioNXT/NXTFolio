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

describe "POST #create" do
  it 'should create GeneralInfo' do
    session[:current_login_user] = {"password" => "Test#1"}
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
end
=begin 
  describe "GET #edit" do
    it "should get GeneralInfo" do
      @general_info = GeneralInfo.new
      get :edit, params: { id: @GeneralInfo.to_param, template: 'general_info/edit' }
      expect(response).to render_template :show_profile
    end
  end

  describe "GET #edit2" do
    it "should get GeneralInfo" do
      @general_info = GeneralInfo.new
      get :edit2, params: { id: @GeneralInfo.to_param, template: 'general_info/edit2' }
      expect(response).to render_template :show_profile
    end
  end

  describe "GET #edit_travel" do
    it "should get GeneralInfo" do
      @general_info = GeneralInfo.new
      get :edit_travel, params: { id: @GeneralInfo.to_param, template: 'general_info/edit_travel' }
      expect(response).to render_template :show_profile
    end
  end
=end
#   describe "POST #update" do 
#     it 'should update GeneralInfo' do
#       @params = ActionController::Parameters.new({
#         general_info: { 
#           first_name: "R", 
#           last_name: "Spec", 
#           month_ofbirth: 01, 
#           day_ofbirth: 31, 
#           year_ofbirth: 1985, 
#           gender: "Female", 
#           country: "United States", 
#           state: "Colorado", 
#           city: "Denver", 
#           compensation: "Any", 
#           facebook_link: "www.fb.com/rspec", 
#           linkedIn_link: "www.li.com/rspec", 
#           instagram_link: "www.ig.com/rspec", 
#           personalWebsite_link: "www.rspec.com", 
#           bio: "I'm RSpec",
#           company: "test company",
#           industry: "test industry",
#           highlights: "test highlights",
#           emailaddr: "test@email.com"
#         }
#       })
      
#       @general_info = GeneralInfo.create!({
#         :first_name => "R", 
#         :last_name => "Spec", 
#         :month_ofbirth => 01, 
#         :day_ofbirth => 31, 
#         :year_ofbirth => 1985, 
#         :gender => "Female", 
#         :country => "United States", 
#         :state => "Colorado", 
#         :city => "Denver", 
#         :compensation => "Any", 
#         :facebook_link => "www.fb.com/rspec", 
#         :linkedIn_link => "www.li.com/rspec", 
#         :instagram_link => "www.ig.com/rspec", 
#         :personalWebsite_link => "www.rspec.com", 
#         :bio => "I'm RSpec",
#         company: "test company",
#         industry: "test industry",
#         highlights: "test highlights",
#         emailaddr: "test@email.com"
#       })
      
      
#       # @params = { :first_name => "Change", :last_name => "Spec", :month_ofbirth => 01, :day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "Colorado", :city => "Denver", :compensation => "Any", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec"}
#       general_info_update_param
#       # @general_info.update_attributes(@params)
#       post :update
#       expect(response).to redirect_to show_profile_show_profile_path
#     end
#     # it 'should not update GeneralInfo' do
#     #   post :update, :general_info => { :first_name => "R", :last_name => "Spec", :month_ofbirth => 01, :day_ofbirth => 31, :year_ofbirth => 1985, :gender => "Female", :country => "United States", :state => "Colorado", :city => "Denver", :compensation => "Any", :facebook_link => "www.fb.com/rspec", :linkedIn_link => "www.li.com/rspec", :instagram_link => "www.ig.com/rspec", :personalWebsite_link => "www.rspec.com", :bio => "I'm RSpec", :specific_profile_id => 0}
#     #   expect(response).to render :edit
#     #   # assert.redirect_to new_general_info_path
#     # end
#   end
  
#   describe "GET #edit_profession" do
#     it "should get GeneralInfo" do
#       @general_info = GeneralInfo.new
#       get :edit_profession, params: { id: @GeneralInfo.to_param, template: 'general_info/new' }
#       # expect(response).to render_template :show_profile
#     end
    
#     it "should not get GeneralInfo" do
#       @general_infos = GeneralInfo.nil?
#       get :edit_profession, params: { id: @GeneralInfo.to_param, template: 'general_info/new' }
#       # expect(response).to render_template :new
#     end
#   end
  
end