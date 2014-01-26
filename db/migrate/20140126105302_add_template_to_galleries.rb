class AddTemplateToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :template, :string
  end
end
