#Import extra tags


module ApplicationHelper

	def liquidize(model_content, view = nil, content = nil)


		theme_root_path = "#{Rails.root}/themes/#{current_user.subdomain}/current_theme"
		theme_file = "/templates/#{view}.html.liquid"
		content = File.read(theme_root_path + theme_file)

		# Load the base theme file system 
		Liquid::Template.file_system =  Liquid::LocalFileSystem.new(theme_root_path)
		

		#file_system = Liquid::LocalFileSystem.new(content)
		Liquid::Template.parse(content).render(model_content, :filters => [LiquidFilters])
	end




end
