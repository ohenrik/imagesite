class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :offer
end
