class DropGalleryTable < ActiveRecord::Migration
  def up
    drop_table :galleries
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
