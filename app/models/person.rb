class Person < ActiveRecord::Base
  belongs_to :photo
  has_many :sub_items, :as => :pageable, :class_name => "PageItem", :dependent => :destroy
  has_many :menu_items, :as => :menuable, :dependent => :destroy

	# Liquid methods
	liquid_methods :thumbnail, :name, :description, :link, :photo, :first_name, :last_name, :email, :title, :id


	def name
		return [self.try(:first_name), self.try(:last_name)].join(" ")
	end

	def link
		"/people/#{id}"
	end

	def thumbnail
		if photo.nil?
			"/assets/default/thumb_no-thumb.png"
		else
			photo.image_url(:thumb)
		end
	end

end
