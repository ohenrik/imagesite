class CreatePublicThemesTable < ActiveRecord::Migration
  
    def change
      create_table :public_themes do |t|
        t.string :name
      t.integer :user_id
      t.string :thumbnail

        t.timestamps
      end
    end

end
