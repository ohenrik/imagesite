class Customer < ActiveRecord::Base
  has_many :tickets

  validates :email, presence: true, uniqueness: true
end
