class Gallery < ActiveRecord::Base

	has_one :user, :as => :home
end
