class Production < ActiveRecord::Base
  belongs_to :photo
  has_many :events, :dependent => :destroy
  has_many :offers, :as => :offerable, :class_name => "Offer", :dependent => :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :events, allow_destroy: true

end
