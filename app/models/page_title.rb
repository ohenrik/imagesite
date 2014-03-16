class PageTitle < ActiveRecord::Base

	has_many :page_items, :as => :pageable, :dependent => :destroy

	# Liquid methods
	liquid_methods :title

end
