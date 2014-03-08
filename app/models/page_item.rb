class PageItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :pageable, polymorphic: true


  has_ancestry

 	# Liquid methods
	liquid_methods :position, :pageable, :is_type

	def is_type
		self.gallery == true ? 'gallery' : self.pageable_type.to_s.downcase 
	end


end
