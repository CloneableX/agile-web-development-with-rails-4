class CapturePriceToItems < ActiveRecord::Migration
  def up
    LineItem.where.not(product_id: nil) do |item|
      product = Product.find(item.product_id)
      item.price = product.price
      item.save!
    end
  end

  def down
    LineItem.all.each do |item|
      item.price = 0.0
      item.save!
    end
  end
end
