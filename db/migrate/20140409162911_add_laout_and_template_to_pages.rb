class AddLaoutAndTemplateToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :layout, index: true
    add_reference :pages, :template, index: true
    remove_column :pages, :template
  end
end
