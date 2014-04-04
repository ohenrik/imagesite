class AddContentToPageItems < ActiveRecord::Migration
  def change
    add_column :page_items, :content, :text
  end
end
