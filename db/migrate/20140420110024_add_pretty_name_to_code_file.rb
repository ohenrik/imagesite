class AddPrettyNameToCodeFile < ActiveRecord::Migration
  def change
    add_column :code_files, :display_name, :string
  end
end
