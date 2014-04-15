class CreateTemplatesSnippetsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :templates, :snippets do |t|
      # t.index [:customer_id, :product_id]
      # t.index [:product_id, :customer_id]
    end
  end
end