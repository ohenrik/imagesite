class AddColumnsToPageItems < ActiveRecord::Migration
  def change
    add_column :page_items, :title, :string
    add_column :page_items, :description, :text
    add_column :page_items, :item_class, :string
    add_column :page_items, :item_link, :string
    add_column :page_items, :item_link_boolean, :boolean
  end
end
