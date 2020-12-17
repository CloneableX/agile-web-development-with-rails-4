require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
	setup do
		@line_item = line_items(:one)
	end

	test "should decrement quantity" do
		original_quantity = @line_item.quantity
		assert_difference('LineItem.count', 0) do
			@line_item.decrement_or_destroy
		end
		assert_equal original_quantity - 1, line_items(:one).quantity
	end

	test "should detroy line_item when quanity equals one" do
		@line_item.quantity = 1
		@line_item.save
		assert_difference('LineItem.count', -1) do
			@line_item.decrement_or_destroy
		end
	end
end
