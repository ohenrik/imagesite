class MenuItem < ActiveRecord::Base
	belongs_to :menu
	belongs_to :menuable, :polymorphic => true
	has_ancestry

	liquid_methods :name, :ancestry, :menuable_type, :menuable_id, :position, :item, :link


	def item
		menu_items.arrange(order: :position)
	end

	def link
		"/tags/1"
	end

end
