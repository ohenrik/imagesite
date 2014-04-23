class AddThumbnailToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :thumbnail, :string
    remove_column :themes, :zip, :string 
  end
end
