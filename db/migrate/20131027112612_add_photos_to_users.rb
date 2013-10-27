class AddPhotosToUsers < ActiveRecord::Migration
  def change
  	add_reference :photos, :user, index: true
  	#remove priveliges
  	remove_column :users, :privileges, :string  if table_exists? :users
  end
end
