class CreatePublicThemes < ActiveRecord::Migration
  def change
    create_table :public_themes do |t|
      t.string :name
      t.string :zip

      t.timestamps
    end
  end
end
