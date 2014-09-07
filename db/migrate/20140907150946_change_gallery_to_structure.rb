class ChangeGalleryToStructure < ActiveRecord::Migration
  def up
  	PageItem.where(other_type: "Gallery").each do |item|
  		item.other_type = "Structure"
  		item.save
  	end
  end

  def down
  	PageItem.where(other_type: "Structure").each do |item|
  		item.other_type = "Gallery"
  		item.save
  	end
  end
end
