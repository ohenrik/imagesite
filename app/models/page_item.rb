class PageItem < ActiveRecord::Base
	belongs_to :page
	belongs_to :pageable, polymorphic: true

	after_initialize :title, :description

	has_ancestry
	acts_as_list scope: [:ancestry]


	
 	# Liquid methods
	liquid_methods :position, :pageable, :is_type, :title, :description, :item_class, :link, :no_item_link, :content, :design, :item_children

	def is_type
		return other_type if self.other_type.present?
		return self.pageable_type.to_s 
	end

	def title
		read_attribute(:title).presence || pageable.try(:name)
	end

	def description
		read_attribute(:description).presence || pageable.try(:description)
	end

	def link
		read_attribute(:link).presence || pageable.try(:link)
	end

	def item_children
		children
	end

end
