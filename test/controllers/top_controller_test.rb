require "test_helper"

class TopControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get top_index_url
    assert_response :success
  end

  test "should get terms" do
    get top_terms_url
    assert_response :success
  end

  test "should get privacy" do
    get top_privacy_url
    assert_response :success
  end

  test "should get contact" do
    get top_contact_url
    assert_response :success
  end
end
