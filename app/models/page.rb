class Page < ActiveRecord::Base

 	validates :title, :status, presence: true

end
