require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get account_signup" do
    get sessions_account_signup_url
    assert_response :success
  end

end
