require 'test_helper'

class GeneralInfoTest < ActiveSupport::TestCase
  fixtures :general_infos

  def test_general_infos

    perl_general_infos = GeneralInfo.update :first_name => general_infos(:perl_cb),
                                         :last_name => general_infos(:perl_cb),
                                         :month_ofbirth => general_infos(:perl_cb),
                                         :day_ofbirth => general_infos(:perl_cb),
                                         :year_ofbirth => general_infos(:perl_cb),
                                         :gender => general_infos(:perl_cb),
                                         :country => general_infos(:perl_cb),
                                         :state => general_infos(:perl_cb),
                                         :city => general_infos(:perl_cb),
                                         :compensation => general_infos(:perl_cb),
                                         :bio => general_infos(:perl_cb),
                                         :created_at => general_infos(:perl_cb),
                                         :specific_profile_id => general_infos(:perl_cb),
                                         :template_id => general_infos(:perl_cb),
                                         :phone => general_infos(:perl_cb),
                                         :updated_at => general_infos(:perl_cb)
    assert true

    # perl_general_infos_copy = Book.find(perl_book.id)
    #
    # assert_equal perl_book.title, perl_book_copy.title
    #
    # perl_book.title = "Ruby Tutorial"
    #
    # assert perl_book.save
    # assert perl_book.destroy
  end

  def test_general_infos2

    perl_general_infos = GeneralInfo.update :first_name => general_infos(:java_cb),
                                            :last_name => general_infos(:java_cb),
                                            :month_ofbirth => general_infos(:java_cb),
                                            :day_ofbirth => general_infos(:java_cb),
                                            :year_ofbirth => general_infos(:java_cb),
                                            :gender => general_infos(:java_cb),
                                            :country => general_infos(:java_cb),
                                            :state => general_infos(:java_cb),
                                            :city => general_infos(:java_cb),
                                            :compensation => general_infos(:java_cb),
                                            :bio => general_infos(:java_cb),
                                            :created_at => general_infos(:java_cb),
                                            :specific_profile_id => general_infos(:java_cb),
                                            :template_id => general_infos(:java_cb),
                                            :phone => general_infos(:java_cb),
                                            :updated_at => general_infos(:java_cb)
    assert true

    # perl_general_infos_copy = Book.find(perl_book.id)
    #
    # assert_equal perl_book.title, perl_book_copy.title
    #
    # perl_book.title = "Ruby Tutorial"
    #
    # assert perl_book.save
    # assert perl_book.destroy
  end

  def test_general_infos_search
      perl_search=GeneralInfo.search :first_name =>general_infos(:perl_cb)
      perl_search1=GeneralInfo.search :first_name =>general_infos(:java_cb)
      assert_not_equal perl_search,perl_search1
  end

end
