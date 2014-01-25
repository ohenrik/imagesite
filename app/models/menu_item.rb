class MenuItem < ActiveRecord::Base
	belongs_to :menu
	belongs_to :menuable, :polymorphic => true
	has_ancestry

	liquid_methods :name, :ancestry, :menuable_type, :menuable_id, :menuable, :position, :item, :link, :has_child


	def item
		menu_items.arrange(order: :position)
	end

	def link
		"#{menuable.link}"
	end

	def has_child
		has_children?
	end

end
