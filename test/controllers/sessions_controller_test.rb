require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    dave = users(:one)
    post :create, name: dave.name, password: 'secret'
    assert_redirected_to admin_path
    assert_equal dave.id, session[:user_id]
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to store_path
  end

  test "should login fail" do
    dave = users(:one)
    post :create, name: dave.name, password: 'Invalid Password'
    assert_redirected_to login_path
    assert_equal 'Invalid username/password combination!', flash[:alert]
  end

  test "should login by any username when users empty" do
    User.delete_all
    post :create, name: 'dave', password: 'secret'

    assert_equal 1, User.count
    assert_equal 'dave', User.find(session[:user_id]).name
  end
end
