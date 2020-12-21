class InitializeDataToPayType < ActiveRecord::Migration
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  def up
    PAYMENT_TYPES.each do |type|
      PayType.create(name: type)
    end
  end

  def down
    pay_types = PayType.where(name: PAYMENT_TYPES)
    pay_types.destroy_all
  end
end
