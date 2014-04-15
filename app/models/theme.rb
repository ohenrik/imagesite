require 'zip'
class Theme < ActiveRecord::Base

	mount_uploader :zip, ThemeUploader

	belongs_to :user
  has_many :code_files
  accepts_nested_attributes_for :code_files
  
	# Validaties theme upload
	validates :zip, :name, presence: true


	# After deletion of the zip file, delete the theme as well.
	#after_destroy :delete_extract
  liquid_methods :id

	# Extract the zip file
    def extract_preview
      file_path = File.join(Rails.public_path, self.zip_url)

      Zip::File.open(file_path) do |zip_file|
        zip_file.each do |file|
          if file.name == 'preview.png' # remember to add other possible file extentions
            f_path = File.join(File.dirname(file_path), file.name)
            #FileUtils.mkdir_p(File.dirname(f_path))
            zip_file.extract(file, f_path){ true }
          end
        end
      end
    end

    # Dele old theme files and extract the new zip file
    def extract_new_preview
      delete_extract
      extract_preview
    end

    # Delete old theme files
    def delete_extract
      file_path = File.join(Rails.public_path, self.zip_url)
      preview_path = File.join(File.dirname(file_path), "preview.png")
      FileUtils.rm(preview_path) unless !File.exist?(preview_path)
    end

    def extract_theme

      # Original Zip-file
      file_path = File.join(Rails.public_path, self.zip_url)

      # Theme directory
      theme_path = Rails.root.join('themes', self.user.subdomain, 'current_theme')

      #delete old theme files
      delete_theme(theme_path) if File.exist?(theme_path) 

      Zip::File.open(file_path) do |zip_file|
        zip_file.each do |file|
          # set the unzip path
          f_path = File.join(theme_path, file.name)
          # Create the folder if it does not exists
          FileUtils.mkdir_p(File.dirname(f_path))
          # Unzip it!
          zip_file.extract(file, f_path){ true }
        end
      end
    end

    def delete_theme(theme_path)
      FileUtils.rm_rf(theme_path)
    end

    def precompile_theme_assets
      theme_path = Rails.root.join('themes', self.user.subdomain, 'current_theme')
      theme_assets_path = Rails.root.join('public', 'assets', 'themes', self.user.subdomain)

      delete_theme(theme_assets_path) if File.exist?(theme_assets_path) 

      # Create the directory if it does not exists
      FileUtils.mkdir_p(theme_assets_path)

      FileUtils.cp_r(File.join(theme_path, "/assets/."), theme_assets_path)

    end

end
