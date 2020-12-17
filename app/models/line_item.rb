class LineItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :cart

	def total_price
		price * quantity
	end

	def decrement_or_destroy
		if quantity == 1
			destroy
			return
		end
		self.quantity -= 1
		save
	end
end
