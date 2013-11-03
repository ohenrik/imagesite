class CreateThemes < ActiveRecord::Migration
  def change
  	if ActiveRecord::Base.connection.current_schema == 'public'
	    create_table :themes do |t|
	      t.string :name
	      t.string :zip

	      t.timestamps
	    end
	end
  end
end
