class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type

  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

  validates :name, :address, :email, presence: true

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart = nil
  		line_items << item
  	end
  end
end
