class AddHomeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_type, :string if table_exists? :users
    remove_column :users, :home_action, :string if table_exists? :users
    remove_column :users, :home_controller, :string if table_exists? :users
  end
end
