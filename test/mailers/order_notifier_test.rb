require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  setup do
    @order = orders(:one)
    add_item_to_order
  end

  test "received" do
    mail = OrderNotifier.received(@order)
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ['depot@example.com'], mail.from
    assert_match /Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(@order)
    assert_equal 'Pragmatic Store Order Shipped', mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

  private
    def add_item_to_order
      line_item = LineItem.create(product: products(:ruby))
      line_item.order = @order
      line_item.save!
    end

end
