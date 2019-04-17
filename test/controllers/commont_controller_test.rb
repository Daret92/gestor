require 'test_helper'

class CommontControllerTest < ActionDispatch::IntegrationTest
  test "should get gps" do
    get commont_gps_url
    assert_response :success
  end

end
