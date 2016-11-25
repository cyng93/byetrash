require 'test_helper'

class WastesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get wastes_new_url
    assert_response :success
  end

end
