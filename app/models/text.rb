class Text < ActiveRecord::Base

	has_many :page_items, :as => :pageable, :dependent => :destroy
end
