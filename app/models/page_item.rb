class PageItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :pagable, polymorphic: true
end
