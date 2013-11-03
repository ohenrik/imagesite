class AddUserToThemes < ActiveRecord::Migration
  def change
    add_reference :themes, :user, index: true
  end
end
