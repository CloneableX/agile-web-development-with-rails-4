xml.document {
  xml.title "Who bought #{@product.title}" 
  xml.updated_at @last_order.try(:updated_at)

  @product.orders.each do |order|
    xml.order {
      xml.id order.id
      xml.address order.address

      xml.line_items {
        order.line_items.each do |item|
          xml.line_item {
            xml.product item.product.title
            xml.quantity item.quantity
            xml.total_price number_to_currency item.total_price
          }
        end
      }

      xml.total_price number_to_currency order.line_items.map(&:total_price).sum
      xml.pay_type order.pay_type.name

      xml.author {
        xml.name order.name
        xml.email order.email
      }
    }
  end
}