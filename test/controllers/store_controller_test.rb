require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /(\$|\￥)[,\d]+\.\d\d/
    assert_equal 1, session[:access_times]
  end

  test "markup needed for store.coffee in place" do
    get :index
    assert_select '.store .entry > img', 3
    assert_select '.entry input[type=submit]', 3
  end

  test "should list products by locale" do
    get :index, locale: 'es'
    I18n.locale = 'en'

    assert_equal 1, assigns(:products).size
    assert_equal products(:java), assigns(:products).first
  end
end
