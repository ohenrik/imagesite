class Theme < ActiveRecord::Base

	mount_uploader :zip, ThemeUploader


end
