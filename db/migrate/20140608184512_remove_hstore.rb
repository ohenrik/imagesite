class RemoveHstore < ActiveRecord::Migration
  def self.up
    execute "DROP EXTENSION IF EXISTS hstore CASCADE"
  end
end
