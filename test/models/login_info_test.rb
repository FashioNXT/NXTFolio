require 'test_helper'

class LoginInfoTest < ActiveSupport::TestCase
  fixtures :general_infos

  def test_login_infos

    perl_general_infos = LoginInfo.update :password => login_infos(:perl_cb),
                                            :is_admin => login_infos(:perl_cb),
                                            :userKey => login_infos(:perl_cb) ,
                                            :email => login_infos(:perl_cb)
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

  def test_login_infos2

    perl_general_infos = LoginInfo.update :password => login_infos(:java_cb),
                                          :is_admin => login_infos(:java_cb),
                                          :userKey => login_infos(:java_cb),
                                          :email => login_infos(:java_cb)
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

  def test_login_infos_infos_search
    perl_search=LoginInfo.search :email =>general_infos(:perl_cb)
    perl_search1=LoginInfo.search :email =>general_infos(:java_cb)
    assert_not_equal perl_search,perl_search1
  end



end
