class MenuItem < ActiveRecord::Base
	belongs_to :menu
	belongs_to :menuable, :polymorphic => true
	has_ancestry

	liquid_methods :name, :ancestry, :menuable_type, :menuable_id, :menuable, :position, :item, :link, :has_child, :url, :new_page

	validates :name, presence: true

	def item
		menu_items.arrange(order: :position)
	end

	def link
		if menuable
			"#{menuable.link}"
		else
			url
		end
	end

	def has_child
		has_children?
	end

end
