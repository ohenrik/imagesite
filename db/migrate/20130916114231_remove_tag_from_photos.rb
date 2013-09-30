class RemoveTagFromPhotos < ActiveRecord::Migration
  def change
  	remove_column :photos, :tag, :string
  end
end
