class AddClientTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :client_token, :string if table_exists? :users
  end
end
