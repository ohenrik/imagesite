class AddSnippetTypeToCodeFiles < ActiveRecord::Migration
  def change
    add_column :code_files, :snippet_type, :string, array: true
  end
end
