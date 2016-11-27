require 'test_helper'

class ThrownWastesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get thrown_wastes_new_url
    assert_response :success
  end

end
