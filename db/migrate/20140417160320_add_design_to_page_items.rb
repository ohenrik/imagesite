class AddDesignToPageItems < ActiveRecord::Migration
  def change
    add_column :page_items, :design, :string
  end
end
