require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {password: '', name: 'person'}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
  	get login_path
  	post login_path, session: {password: 'MyString', email: @user.email}
  	assert_redirected_to root_path
  	follow_redirect!
  	assert_template 'search_pages/search'
  	assert_select "a[href=?]", login_path, count: 0
  	assert_select "a[href=?]", logout_path
  	assert_select "li.dropdown a", text: "#{@user.name}"

  	delete logout_path
  	assert_not is_logged_in?
  	assert_redirected_to root_path
  	follow_redirect!
  	assert_select "[href=?]", login_path
  	assert_select "a[href=?]", logout_path, count: 0
  	assert_select "li.dropdown a", count: 0
  end
end
