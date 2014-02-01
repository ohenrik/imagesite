class Tag < ActiveRecord::Base

	has_many :taggings, dependent: :destroy 
	has_many :photos, through: :taggings
	has_many :menu_items, :as => :menuable, :dependent => :destroy

	validates :name, presence: true

	liquid_methods :name, :id, :link


	def link
		"/tags/#{id}"
	end



end
