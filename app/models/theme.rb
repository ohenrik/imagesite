class Theme < ActiveRecord::Base

	mount_uploader :zip, ThemeUploader

	belongs_to :user

	# Validaties theme upload
	validates :zip, :name, presence: true

	# After uploaded zip file extract the content of the file
	  after_create :extract_zip, only: [:create]

	  # After uploaded a new zip file delete old exctract and extract the content of the new file.
	  after_update :extract_new_zip, only: [:edit]

	  # After deletion of the zip file, delete the theme as well.
	  after_destroy :delete_extract, only: [:destroy]

end
