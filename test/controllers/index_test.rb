require 'test_helper'

class IndexTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_select "a[href=?]", search_profile_search_path
    end
  end

end
