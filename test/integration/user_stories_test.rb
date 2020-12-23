require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  fixtures :orders

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    get '/'
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items.first.product

    get '/orders/new'
    assert_response :success
    assert_template 'new'

    post_via_redirect '/orders',
                      order: {
                        name: 'Hank Xu',
                        address: '123 Main St',
                        email: 'hank@customer.com',
                        pay_type_id: pay_types(:one).id
                      }
    assert_response :success
    assert_template 'index'

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal 'Hank Xu', order.name
    assert_equal '123 Main St', order.address
    assert_equal 'hank@customer.com', order.email

    assert_equal 1, order.line_items.size
    assert_equal ruby_book, order.line_items.first.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['hank@customer.com'], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end

  test "ship order" do
    order = orders(:one)
    order.pay_type = pay_types(:one)
    order.save!
    ruby_book = products(:ruby)

    get '/products'
    assert_response :success
    assert_template 'index'

    get "/products/#{ruby_book.id}/who_bought"
    assert_response :success
    assert_template 'who_bought'

    put "/orders/#{order.id}"
    assert_response 302

    mail = ActionMailer::Base.deliveries.last
    assert_equal [order.email], mail.to
    assert_equal 'Pragmatic Store Order Shipped', mail.subject

    shipped_order = Order.find(order.id)
    assert_not_nil shipped_order.ship_date
  end
end
