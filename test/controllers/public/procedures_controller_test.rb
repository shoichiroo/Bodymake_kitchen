require "test_helper"

class Public::ProceduresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_procedures_new_url
    assert_response :success
  end
end
