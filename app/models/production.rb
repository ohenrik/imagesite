class Production < ActiveRecord::Base
  belongs_to :photo
  has_many :events, :dependent => :destroy
  has_many :offers, :as => :offerable, :class_name => "Offer", :dependent => :destroy


  has_many :sub_items, :as => :pageable, :class_name => "PageItem", :dependent => :destroy
  has_many :menu_items, :as => :menuable, :dependent => :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :events, allow_destroy: true

  # Liquid methods
  liquid_methods :thumbnail, :name, :description, :link, :events, :photos

  
	def link
		"/productions/#{id}"
	end

  def thumbnail
    if photo.blank?
      "/assets/default/large_thumb_no-thumb.png"
    else
      photo.image_url(:medium)
    end
  end

end
