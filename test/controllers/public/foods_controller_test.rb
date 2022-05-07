require "test_helper"

class Public::FoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_foods_new_url
    assert_response :success
  end
end
