class DropSettingsTable < ActiveRecord::Migration
  def up
    drop_table :settings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
