class AddIndexToMenuItems < ActiveRecord::Migration
  def change
  	add_index :menu_items, :position
  	add_index :menu_items, :ancestry
  end
end
