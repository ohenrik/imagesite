class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.decimal :price
      t.string :currency
      t.references :offer, index: true
      t.references :customer, index: true

      t.timestamps
    end
  end
end
