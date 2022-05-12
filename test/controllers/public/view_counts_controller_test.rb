require "test_helper"

class Public::ViewCountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_view_counts_index_url
    assert_response :success
  end
end
