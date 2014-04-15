class CodeFile < ActiveRecord::Base
	belongs_to :theme
	has_many :layout_for_pages, foreign_key: "layout_id", class_name: "Page"
	has_many :template_for_pages, foreign_key: "template_id", class_name: "Page"
	#has_and_belongs_to_many :templates, class_name: "CodeFile", foreign_key: "template_id", join_table: "templates_snippets", association_foreign_key: "snippet_id"
	#has_and_belongs_to_many :snippets, class_name: "CodeFile", foreign_key: "snippet_id", join_table: "templates_snippets", association_foreign_key: "template_id"

	validates :name, :hierarchy, presence: true

	mount_uploader :static_file, StaticFileUploader

end
