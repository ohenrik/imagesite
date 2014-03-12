class Menu < ActiveRecord::Base
	has_many :menu_items, :dependent => :destroy

	liquid_methods :name, :menu_items, :items

	def items
		menu_items.arrange(order: :position)
	end



end
