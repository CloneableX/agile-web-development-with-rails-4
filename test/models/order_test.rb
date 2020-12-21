require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:one)
  end

  test "should not save invalid pay_type_id" do
    order = Order.new(address: @order.address, email: @order.email, name: @order.name, pay_type_id: 'my test' )
    order.save

    assert order.invalid?
    assert_equal ['Please select valid pay type'], order.errors[:pay_type]
  end
end
