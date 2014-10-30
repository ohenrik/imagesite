class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :offer

  liquid_methods :offer

end
