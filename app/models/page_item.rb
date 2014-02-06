class PageItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :pageable, polymorphic: true


  has_ancestry

end
