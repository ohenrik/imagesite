class Tag < ActiveRecord::Base

	has_many :taggings, dependent: :destroy 
	has_many :photos, through: :taggings

	liquid_methods :name, :tag_link

	
	def tag_link
		"/photos/tags/#{tag}"
	end


end
