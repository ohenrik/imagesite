class CreateCodeFiles < ActiveRecord::Migration
  def change
    create_table :code_files do |t|
      t.references :theme, index: true
      t.string :name
      t.text :code
      t.string :hierarchy

      t.timestamps
    end
  end
end
