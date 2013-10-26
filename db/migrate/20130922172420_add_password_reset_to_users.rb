class AddPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token, :string  if table_exists? :users
    add_column :users, :password_reset_sent_at, :datetime  if table_exists? :users
  end
end
