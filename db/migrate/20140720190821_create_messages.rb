class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :content
      t.string :sender_email
      t.string :sender_name
      t.integer :sender_id
      t.string :sender_type
      t.integer :receiver_id
      t.string :receiver_type
      t.string :message_type

      t.timestamps
    end
  end
end
