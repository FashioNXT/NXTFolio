require 'test_helper'

class SearchProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    assert true
  end

  def test_general_infos_search
    perl_search=GeneralInfo.search :first_name =>general_infos(:perl_cb)
    perl_search1=GeneralInfo.search :first_name =>general_infos(:perl_cb)
    assert_equal perl_search,perl_search1
  end


  def test_general_infos_search_2
    perl_search=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    perl_search1=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    assert_equal perl_search,perl_search1
  end

  def test_general_infos_search_3
    searchArg=Hash.new
    searchArg["first_name"]="Avinash"
    searchArg["first_name_regex"]="Contains"
    perl_search=GeneralInfo.search searchArg
    assert_not_nil perl_search

   # perl_search1=GeneralInfo.search :last_name =>general_infos(:perl_cb)


    #assert_equal perl_search,perl_search1
  end

  #test equality of two searched strings
  def test_general_infos_search_4
    searchArg=Hash.new
    searchArg["first_name"]="Avinash"
    searchArg["first_name_regex"]="Contains"
    perl_search=GeneralInfo.search searchArg
    assert_not_nil perl_search

    searchArg=Hash.new
    searchArg["last_name"]="Saxena"
    searchArg["last_name_regex"]="Contains"

    perl_search1=GeneralInfo.search searchArg
    assert_not_nil perl_search1
    # perl_search1=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    assert_equal perl_search,perl_search1
  end


  #Phone number and lastname searches for same
  def test_general_infos_search_5
    searchArg=Hash.new
    searchArg["phone"]="979"
    perl_search=GeneralInfo.search searchArg
    assert_not_nil perl_search

    searchArg=Hash.new
    searchArg["last_name"]="Saxena"
    searchArg["last_name_regex"]="Contains"

    perl_search1=GeneralInfo.search searchArg
    assert_not_nil perl_search1
    # perl_search1=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    assert_equal perl_search,perl_search1
  end

  #search for different profiles
  def test_general_infos_search_6
    searchArg=Hash.new
    searchArg["phone"]="979"
    searchArg["first_name_regex"]="Contains"
    perl_search=GeneralInfo.search searchArg
    assert_not_nil perl_search

    searchArg=Hash.new
    searchArg["phone"]="828"
    perl_search1=GeneralInfo.search searchArg
    assert_not_nil perl_search1

    assert_equal perl_search,perl_search1
  end


  def test_login_infos_search_1
    perl_search=LoginInfo.search :email =>general_infos(:perl_cb)
    perl_search1=LoginInfo.search :email =>general_infos(:java_cb)
    assert_not_equal perl_search,perl_search1
  end

  def test_login_infos_search_2
    perl_search=LoginInfo.search :email =>general_infos(:perl_cb)
    perl_search1=LoginInfo.search :email =>general_infos(:perl_cb)
    assert_equal perl_search,perl_search1
  end

  def test_login_infos_search_3
    perl_search=LoginInfo.search :email =>general_infos(:perl_cb)
    assert_not_nil perl_search
  end

  def test_login_infos_search_3
    perl_search=LoginInfo.search :email =>'undefined@gmail.com'
    assert_not_nil perl_search
  end
end

