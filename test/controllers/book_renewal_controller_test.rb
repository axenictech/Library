require 'test_helper'

class BookRenewalControllerTest < ActionController::TestCase
  test "should get search_renewal" do
    get :search_renewal
    assert_response :success
  end

end
