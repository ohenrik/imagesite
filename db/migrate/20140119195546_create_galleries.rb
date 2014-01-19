class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.string :gallery_type

      t.timestamps
    end
  end
end
