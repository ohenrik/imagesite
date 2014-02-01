class RenameSubtitleOnGalleries < ActiveRecord::Migration
  def change
  	rename_column :galleries, :subtitle, :second_title
  end
end
