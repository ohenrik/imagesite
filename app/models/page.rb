class Page < ActiveRecord::Base

 	validates :title, :status, presence: true
 	belongs_to :photo
 	has_many :menu_items, :as => :menuable, :dependent => :destroy
 	has_one :user, :as => :home

 	has_many :page_items, :as => :pageable, :dependent => :destroy
 	has_many :sub_items, :foreign_key => "page_id", :class_name => "PageItem", :dependent => :destroy
 	


	# Liquid methods
	liquid_methods :page, :thumbnail, :title, :second_title, :content, :excerpt, :link, :items


	def link
		"/pages/#{id}"
	end

	def page
		page
	end

	def thumbnail
		if photo.nil?
			"/assets/default/large_thumb_no-thumb.png"
		else
			photo.image_url(:large_thumb)
		end
	end

	def items
		sub_items.arrange(order: :position)
	end

end
