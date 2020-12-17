require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_path
    assert_equal 0, session[:access_times]
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', 0) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to store_path
  end

  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      xhr :post, :create, product_id: products(:ruby).id
    end

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby 1.9/
    end
  end

  test "should decrement line_item by ajax" do
    product_id = products(:ruby).id
    cart = add_product_to_cart(product_id)
    line_item = cart.add_product(product_id)
    line_item.save
    xhr :delete, :destroy, id: line_item

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', '1×'
    end
  end

  test "should hidden cart when all line_items destroyed" do
    cart = add_product_to_cart(products(:ruby).id)
    xhr :delete, :destroy, id: cart.line_items.first

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr', 1
    end
  end

  private

  def add_product_to_cart(product_id)
    cart = Cart.new
    cart.add_product(product_id)
    cart.save
    session[:cart_id] = cart.id
    return cart
  end

end
