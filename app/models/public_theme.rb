class PublicTheme < ActiveRecord::Base

	belongs_to :user
	has_many :public_code_files
	accepts_nested_attributes_for :public_code_files

		# Validaties theme upload
	validates :name, presence: true

	liquid_methods :id

		
end
