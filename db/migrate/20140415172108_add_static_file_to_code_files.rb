class AddStaticFileToCodeFiles < ActiveRecord::Migration
  def change
    add_column :code_files, :static_file, :string
    add_column :code_files, :available_in, :integer, array: true 
  end
end
