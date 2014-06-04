class AddCardInformationToUserCreditCards < ActiveRecord::Migration
  def change
    add_column :user_credit_cards, :card_type, :string if table_exists? :user_credit_cards
    add_column :user_credit_cards, :country, :string if table_exists? :user_credit_cards
    add_column :user_credit_cards, :expire_month, :integer if table_exists? :user_credit_cards
    add_column :user_credit_cards, :expire_year, :integer if table_exists? :user_credit_cards
    add_column :user_credit_cards, :last4, :string if table_exists? :user_credit_cards
  end
end
