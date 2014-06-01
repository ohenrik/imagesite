class DropTextTable < ActiveRecord::Migration
  def up
    drop_table :texts if table_exists? :texts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
