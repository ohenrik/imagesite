class Page < ActiveRecord::Base

 	validates :title, :status, presence: true
 	belongs_to :photo

end
