require 'test_helper'

class ApiAppControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get api_app_login_url
    assert_response :success
  end

end
