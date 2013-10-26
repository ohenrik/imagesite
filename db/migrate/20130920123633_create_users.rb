class CreateUsers < ActiveRecord::Migration

  if ActiveRecord::Base.connection.current_schema == 'public' # Only for public schema
    
    def change
      create_table :users do |t|
        t.string :email
        t.string :password_digest
        t.string :first_name
        t.string :last_name
        t.string :subdomain

        t.timestamps
      end
    end
  
  end

end
