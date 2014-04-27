class DropPublicThemesAndPublicCodeFilesTalbe < ActiveRecord::Migration
	def up
		drop_table :public_themes
		drop_table :public_code_files
	end

	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
