class Offer < ActiveRecord::Base
	belongs_to :offerable, polymorphic: true
end
