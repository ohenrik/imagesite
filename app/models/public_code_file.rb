class PublicCodeFile < ActiveRecord::Base
	belongs_to :public_theme

	validates :name, :hierarchy, presence: true

	validates :name, format: {:with => /\A[^\\:*?"$&+,:;=?@~\[\]`<>%#|\/]+\z/, message: "Does not allow any of these characters ^ : * ? $ & + , : ; = ? @ ~ ] [ ` < > % # | \ / "}

	mount_uploader :static_file, StaticFileUploader
end
