class RemoveCurrentThemeFolderFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_theme_folder if table_exists? :users
  end
end
