require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "valid signup information" do
     get new_user_path
     assert_difference 'User.count', 1 do
     	post_via_redirect users_path, user: {name: "Obialo Chidiebere",
     										 email: "obialo@test.com",
     										 password: "iec123",
     										 password_confirmation: "iec123"}
     end
     assert_template 'search_pages/search'
     assert_not is_logged_in?
     assert_not flash.empty?
  end
end
