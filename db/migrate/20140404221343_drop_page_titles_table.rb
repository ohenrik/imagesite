class DropPageTitlesTable < ActiveRecord::Migration
  def up
    drop_table :page_titles if table_exists? :page_titles
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
