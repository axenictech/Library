require 'test_helper'

class LibraryBookRenewalsControllerTest < ActionController::TestCase
  test "should get search_book" do
    get :search_book
    assert_response :success
  end

end
