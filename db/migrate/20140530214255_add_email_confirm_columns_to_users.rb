class AddEmailConfirmColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirm_email_token, :string if table_exists? :users
    add_column :users, :confirm_email_sent_at, :datetime if table_exists? :users
    add_column :users, :confirmed_email_at, :datetime if table_exists? :users
  end
end
