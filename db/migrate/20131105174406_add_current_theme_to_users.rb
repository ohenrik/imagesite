class AddCurrentThemeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_theme_folder, :string if table_exists? :users
  end
end
