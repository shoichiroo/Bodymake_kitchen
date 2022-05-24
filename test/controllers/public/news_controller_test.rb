require "test_helper"

class Public::NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_news_index_url
    assert_response :success
  end
end
