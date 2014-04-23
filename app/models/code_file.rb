class CodeFile < ActiveRecord::Base
	belongs_to :theme
	has_many :layout_for_pages, foreign_key: "layout_id", class_name: "Page"
	has_many :template_for_pages, foreign_key: "template_id", class_name: "Page"
	#has_and_belongs_to_many :templates, class_name: "CodeFile", foreign_key: "template_id", join_table: "templates_snippets", association_foreign_key: "snippet_id"
	#has_and_belongs_to_many :snippets, class_name: "CodeFile", foreign_key: "snippet_id", join_table: "templates_snippets", association_foreign_key: "template_id"

	validates :name, :hierarchy, presence: true
	validates :name, format: {:with => /\A[^\\:*?"$&+,:;=?@~\[\]`<>%#|\/]+\z/, message: "Does not allow any of these characters ^ : * ? $ & + , : ; = ? @ ~ ] [ ` < > % # | \ / "}

	mount_uploader :static_file, StaticFileUploader

	after_initialize :display_name


	def display_name
		read_attribute(:display_name).presence || try(:name)
	end


	def hierarchy_up
		case self.hierarchy
		when 'template'
			return 'layout'
		when 'snippet'
			return 'template'
		else
			return nil
		end
	end

end
