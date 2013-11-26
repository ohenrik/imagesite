class AddThumbnailToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :photo, index: true
  end
end
