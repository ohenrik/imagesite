class AddAddressAndVenueToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address, :string
    add_column :events, :venue, :string
    remove_column :events, :location
  end
end
