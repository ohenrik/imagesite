class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.text :description
      t.string :email
      t.string :phone
      t.string :mobile_phone
      t.references :photo, index: true

      t.timestamps
    end
  end
end
