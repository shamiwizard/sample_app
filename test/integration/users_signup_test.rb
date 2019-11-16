require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                          email: "random@mail.com",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    end
    assert_select 'form[action^="/signup"]'
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Andy',
                                        email: 'boss@letda.com',
                                        password: '123456',
                                        password_confirmation: '123456' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end

end
