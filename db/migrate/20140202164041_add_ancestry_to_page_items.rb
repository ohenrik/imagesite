class AddAncestryToPageItems < ActiveRecord::Migration
  def change
    add_column :page_items, :ancestry, :string 
  end
end
