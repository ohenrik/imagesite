class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.references :photo, index: true

      t.timestamps
    end
  end
end
