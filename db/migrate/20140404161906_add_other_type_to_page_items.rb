class AddOtherTypeToPageItems < ActiveRecord::Migration
  def change
    add_column :page_items, :other_type, :string
  end
end
