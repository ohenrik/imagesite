class AddProductionsToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :production, index: true
  end
end
