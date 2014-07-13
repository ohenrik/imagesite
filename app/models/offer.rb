class Offer < ActiveRecord::Base
	belongs_to :offerable, polymorphic: true
	has_many :tickets

	liquid_methods :price, :name
end
