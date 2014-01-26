class AddUrlToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :url, :string
  end
end
