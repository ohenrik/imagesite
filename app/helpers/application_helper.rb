#Import extra tags


module ApplicationHelper

	def liquidize(model_content, view = nil, content = nil)


		theme_root_path = "#{Rails.root}/public/uploads/themes/#{current_user.subdomain}/#{current_user.theme.id}/theme_files"
		theme_file = "/templates/#{view}.html.liquid"
		content = File.read(theme_root_path + theme_file)




		# Load the base theme file system 
		Liquid::Template.file_system =  Liquid::LocalFileSystem.new(Rails.root.to_s + "/public/uploads/themes/#{current_user.subdomain}/#{current_user.theme.id}/theme_files")
		


		#file_system = Liquid::LocalFileSystem.new(content)
		Liquid::Template.parse(content).render(model_content, :filters => [LiquidFilters])
	end




end
