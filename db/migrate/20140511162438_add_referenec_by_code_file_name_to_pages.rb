class AddReferenecByCodeFileNameToPages < ActiveRecord::Migration
	def up
		add_column :pages, :template_name, :string
		add_column :pages, :layout_name, :string
		add_index :pages, :layout_name
		add_index :pages, :template_name
	end

	def down
		remove_column :pages, :template_name, :string
		remove_column :pages, :layout_name, :string
		remove_index :pages, :layout_name
		remove_index :pages, :template_name
	end
end
