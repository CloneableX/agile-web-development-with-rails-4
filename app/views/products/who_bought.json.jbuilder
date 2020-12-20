json.title "Who bought #{@product.title}"
json.updated_at @last_order.try(:updated_at)

json.orders @product.orders do |order|
  json.order do
    json.(order, :id, :address, :pay_type)
    json.author do
      json.extract! order, :name, :email
    end

    json.line_items order.line_items do |item|
      json.product item.product.title
      json.(item, :quantity)
      json.total_price number_to_currency item.total_price
    end

    json.total_price number_to_currency order.line_items.map(&:total_price).sum
  end
end