class AddThemeToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :theme, index: true if table_exists? :users
  end
end
