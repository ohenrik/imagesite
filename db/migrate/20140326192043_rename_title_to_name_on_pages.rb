class RenameTitleToNameOnPages < ActiveRecord::Migration
  def change
  	# Rename title to name
  	rename_column :pages, :title, :name
  	# Remove the second title
  	remove_column :pages, :second_title
  end
end
