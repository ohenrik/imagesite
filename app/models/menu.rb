class Menu < ActiveRecord::Base
	has_many :menu_items

	liquid_methods :name, :menu_items



end
