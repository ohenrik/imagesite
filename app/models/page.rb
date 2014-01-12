class Page < ActiveRecord::Base

 	validates :title, :status, presence: true
 	belongs_to :photo
 	has_many :menu_items, :as => :menuable, :dependent => :destroy


	# Liquid methods
	liquid_methods :page, :thumbnail, :title, :content, :excerpt, :link


	def link
		"/pages/#{id}"
	end

	def page
		page
	end

	def thumbnail
		photo.image_url(:large_thumb)
	end

end
