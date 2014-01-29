class AddSettingsColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :site_title, :string if table_exists? :users
    add_column :users, :site_tagline, :string if table_exists? :users
    add_column :users, :alias_domain, :string if table_exists? :users
    add_column :users, :home_controller, :string if table_exists? :users
    add_column :users, :home_action, :string if table_exists? :users
    add_column :users, :home_id, :integer if table_exists? :users
  end
end
