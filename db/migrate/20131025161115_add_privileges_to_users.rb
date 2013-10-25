class AddPrivilegesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privileges, :string  if table_exists? :users
  end
end
