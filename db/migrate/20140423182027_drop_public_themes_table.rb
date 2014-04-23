class DropPublicThemesTable < ActiveRecord::Migration
	def up
		drop_table :public_themes
	end

	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
