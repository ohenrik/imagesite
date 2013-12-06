class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.references :menu, index: true
      t.belongs_to :menuable, polymorphic: true
      t.string :name
      t.string :description
      t.boolean :new_page
      t.string :ancestry

      t.timestamps
    end
  end
end
