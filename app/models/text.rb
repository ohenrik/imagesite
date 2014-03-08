class Text < ActiveRecord::Base

	has_many :page_items, :as => :pageable, :dependent => :destroy

	# Liquid methods
	liquid_methods :content


end
