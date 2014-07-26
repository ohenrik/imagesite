class AddCommentableToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :commentable_id, :integer
    add_column :messages, :commentable_type, :string
  end
end
