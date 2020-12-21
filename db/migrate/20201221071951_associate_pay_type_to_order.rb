class AssociatePayTypeToOrder < ActiveRecord::Migration
  def up
    Order.all.each do |order|
      pay_type = PayType.where(name: order.pay_type).first
      next unless pay_type
      Order.update(order.id, pay_type_id: pay_type.id)
    end
  end

  def down
    Order.where.not(pay_type_id: nil).each do |order|
      pay_type = PayType.find(order.pay_type_id)
      Order.update(order.id, pay_type: pay_type.name, pay_type_id: nil)
    end
  end
end
