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
end
