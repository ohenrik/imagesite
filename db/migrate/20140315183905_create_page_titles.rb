class CreatePageTitles < ActiveRecord::Migration
  def change
    create_table :page_titles do |t|
      t.string :title

      t.timestamps
    end
  end
end
