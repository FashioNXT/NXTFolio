require 'test_helper'

class GeneralInfoControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  #should not save without any parameters
  test "save without any paramters" do
    @general_infos = GeneralInfo.new
    assert !@general_infos.save
  end

  # test "save with all parameters" do
  #
  #   # params[:general_info][:first_name] == "Avinash"
  #   # params[:general_info][:phone] ="979"
  #   # params[:general_info][:last_name] == "Saxena"
  #   # params[:general_info][:month_ofbirth] == "Feb"
  #   # params[:general_info][:day_ofbirth] == "13"
  #   # params[:general_info][:year_ofbirth] == "1990"
  #   # params[:general_info][:country] == "United States"
  #   # params[:general_info][:state] == "Texas"
  #   # params[:general_info][:city] == "College Station"
  #   #
  #   # @general_info = GeneralInfo.new(params)
  #   # @general_info.userKey = session[:current_user_key]
  #
  #   general_infos :create, :post => { :general_info => {:first_name=> "Avinash"} }
  #
  #
  # end

  # test "creating an article" do
  #   visit articles_path
  #
  #   click_on "New Article"
  #
  #   fill_in "Title", with: "Creating an Article"
  #   fill_in "Body", with: "Created this article successfully!"
  #
  #   click_on "Create Article"
  #
  #   assert_text "Creating an Article"
  # end


  test "show" do
    assert true
  end


end
