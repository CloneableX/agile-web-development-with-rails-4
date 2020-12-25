require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create user when users empty" do
    User.delete_all
    user = User.create_if_empty('dave', 'secret')
    assert_equal 1, User.count
    assert_equal 'dave', user.name
  end

  test "should find user by name when users not empty" do
    dave = users(:one)
    assert_difference('User.count', 0) do
      user = User.create_if_empty(dave.name, 'secret')
      assert_equal dave, user
    end
  end
end
