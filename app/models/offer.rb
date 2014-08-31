class Offer < ActiveRecord::Base
	belongs_to :offerable, polymorphic: true
	has_many :tickets
	has_many :line_items
  has_many :carts, through: :line_items
  
	liquid_methods :price, :name, :id

	before_destroy :ensure_not_referenced_by_any_line_item

private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end

end
