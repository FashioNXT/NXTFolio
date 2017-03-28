require 'test_helper'

class SearchProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get search_profile_search_url
    assert_response :success
  end

  test "should get show" do
    get search_profile_show_url
    assert_response :success
  end

end
