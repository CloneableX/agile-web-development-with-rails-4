require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, cart: {  }
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    get :show, id: @cart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart
    assert_response :success
  end

  test "should update cart" do
    patch :update, id: @cart, cart: {  }
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should destroy cart" do
    assert_difference('Cart.count', 0) do
      session[:cart_id] = @cart.id
      delete :destroy, id: @cart
    end

    assert_redirected_to store_path
    assert_not_nil session[:cart_id]

    line_items = LineItem.where({cart_id: @cart.id})
    assert line_items.empty?
  end

  test "should destroy cart by ajax" do
    assert_difference('Cart.count', 0) do
      session[:cart_id] = @cart.id
      xhr :delete, :destroy, id: @cart
    end

    assert_response :success
  end

  test "should send email when invalid cart happed" do
    get :show, id: 'Invalid Cart Id'

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['admin@example.com'], mail.to
    assert_equal 'Depot Error Report', mail.subject
  end

end
