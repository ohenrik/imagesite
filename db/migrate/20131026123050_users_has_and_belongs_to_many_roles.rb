class UsersHasAndBelongsToManyRoles < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.current_schema == 'public'
      create_table :roles do |t|
        t.string :role
        t.timestamps
      end

      create_table :roles_users do |t|
        t.belongs_to :user, :null => false
        t.belongs_to :role, :null => false
      end

        Role.create :role => "admin"
      Role.create :role => "premium"
      Role.create :role => "member"
      Role.create :role => "guest"
      Role.create :role => "trail"
    end
  end
end
