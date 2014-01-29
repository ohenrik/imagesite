class AddSlugToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :slug, :string
  end
end
