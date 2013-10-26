class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string  if table_exists? :users
  end
end
