require "test_helper"

class MountainLinksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mountain_links_show_url
    assert_response :success
  end
end
