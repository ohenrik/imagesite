class AddSecondTitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :second_title, :string
  end
end
