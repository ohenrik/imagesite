class Page < ActiveRecord::Base

 	validates :title, :status, presence: true
 	belongs_to :photo
 	has_many :menu_items, :as => :menuable, :dependent => :destroy
 	has_one :user, :as => :home


	# Liquid methods
	liquid_methods :page, :thumbnail, :title, :second_title, :content, :excerpt, :link


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
