class CreateUserCreditCards < ActiveRecord::Migration
  def change
		if ActiveRecord::Base.connection.current_schema == 'public' # Only for public schema 
	    create_table :user_credit_cards do |t|
	      t.string :payment_token
	      t.references :user
	      t.timestamps
	    end
	  end
	end
end
