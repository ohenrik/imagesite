class CreatePublicCodeFiles < ActiveRecord::Migration
 
    def change
      create_table :public_code_files do |t|
        t.references :public_theme, index: true
        t.string :name
        t.string :display_name
        t.text :code
        t.string :hierarchy
        t.string :available_to, array: true
        t.string :available_in, array: true
        t.string :static_file

        t.timestamps
      end
    end

end
