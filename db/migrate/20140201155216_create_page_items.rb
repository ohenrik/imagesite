class CreatePageItems < ActiveRecord::Migration
  def change
    create_table :page_items do |t|
      t.integer :position
      t.references :page, index: true
      t.references :pagable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
