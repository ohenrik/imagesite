class Theme < ActiveRecord::Base

	mount_uploader :zip, ThemeUploader
	belongs_to :user


end
