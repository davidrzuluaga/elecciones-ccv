require 'test_helper'

class ViewControllerTest < ActionDispatch::IntegrationTest
  test "should get indexç" do
    get view_indexç_url
    assert_response :success
  end

end
