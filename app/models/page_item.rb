class PageItem < ActiveRecord::Base
	belongs_to :page
	belongs_to :pageable, polymorphic: true

	after_initialize :title

	has_ancestry

 	# Liquid methods
	liquid_methods :position, :pageable, :is_type

	def is_type
		self.gallery == true ? 'Gallery' : self.pageable_type.to_s 
	end


	def title
		read_attribute(:title).presence || pageable.try(:name)
	end


end
