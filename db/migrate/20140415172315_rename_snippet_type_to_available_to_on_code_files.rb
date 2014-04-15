class RenameSnippetTypeToAvailableToOnCodeFiles < ActiveRecord::Migration
  def change
  	rename_column :code_files, :snippet_type, :available_to
  end
end
