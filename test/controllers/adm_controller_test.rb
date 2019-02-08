require 'test_helper'

class AdmControllerTest < ActionDispatch::IntegrationTest
  test "should get rol" do
    get adm_rol_url
    assert_response :success
  end

end
