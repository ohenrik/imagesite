class PageItem < ActiveRecord::Base
	belongs_to :page
	belongs_to :pageable, polymorphic: true

	after_initialize :title

	has_ancestry

 	# Liquid methods
	liquid_methods :position, :pageable, :is_type, :title, :description, :item_class, :item_link, :no_item_link, :content

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


end
