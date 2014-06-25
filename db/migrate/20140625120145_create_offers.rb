class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.decimal :price
      t.string :currency
      t.integer :capacity
      t.integer :offerable_id
      t.string :offerable_type

      t.timestamps
    end
  end
end
