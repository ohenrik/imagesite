class Event < ActiveRecord::Base
  belongs_to :photo
  has_many :sub_items, :as => :pageable, :class_name => "PageItem", :dependent => :destroy

  validates :name, presence: true

  def start_datetime
  	if !start_time.blank?
  		DateTime.new(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min, start_time.sec, start_time.zone)	
  	else
  		start_date
  	end
  end

  def end_datetime
	DateTime.new(end_date.year, end_date.month, end_date.day, end_time.hour, end_time.min, end_time.sec, end_time.zone)
  end

end