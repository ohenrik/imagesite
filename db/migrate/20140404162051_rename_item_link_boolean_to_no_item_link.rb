class RenameItemLinkBooleanToNoItemLink < ActiveRecord::Migration
  def change
    rename_column :page_items, :item_link_boolean, :no_item_link
  end
end
