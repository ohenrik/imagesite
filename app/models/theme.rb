class Theme < ActiveRecord::Base

	mount_uploader :zip, ThemeUploader

	belongs_to :user

	# Validaties theme upload
	validates :zip, :name, presence: true




end
