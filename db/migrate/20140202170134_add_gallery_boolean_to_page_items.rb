class AddGalleryBooleanToPageItems < ActiveRecord::Migration
  def change
    add_column :page_items, :gallery, :boolean
  end
end
