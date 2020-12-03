require 'test_helper'

class AccessCounterTest < ActionController::TestCase
  include AccessCounter

  test "should initialize access times" do
    increase_times
    assert_equal 1, @access_times
    assert_equal 1, session[:access_times]
  end

  test "should get access times from session" do
    access_times = 1
    session[:access_times] = access_times
    increase_times
    assert_equal access_times + 1, @access_times
    assert_equal access_times + 1, session[:access_times]
  end

  test "should reset access times" do
    increase_times
    reset_times
    assert_equal 0, @access_times
    assert_equal 0, session[:access_times]
  end

  test "should raise RoutingError when accessed over 5 times" do
    (0..4).each {increase_times}
    assert_raise(ActionController::RoutingError) { increase_times }
  end
end
