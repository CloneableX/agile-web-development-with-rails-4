require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "should build new line item when not same line item" do
    cart = Cart.new
    current_item = cart.add_product(products(:ruby).id)
    assert !current_item.nil?
    assert_equal 1, current_item.quantity
  end

  test "should increase quantity when there's same line item" do
    cart = Cart.new
    cart.add_product(products(:ruby).id)
    cart.save!
    current_item = cart.add_product(products(:ruby).id)
    current_item.save
    assert_equal 1, Cart.find(cart.id).line_items.count
    assert_equal 2, current_item.quantity
  end

  test "should capture product price to line item" do
    product = products(:ruby)
    cart = Cart.new
    item = cart.add_product(product.id)
    assert_equal product.price, item.price
  end
end
