class Cart < ActiveRecord::Base

	has_many :line_items, dependent: :destroy
	has_many :offers, through: :line_items

	liquid_methods :line_items, :item_count, :total_price

	def item_count
		line_items.count || 0
	end

	def total_price
		offers.sum(:price)
	end

end
