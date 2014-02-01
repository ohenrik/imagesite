module ApplicationHelper

	def liquidize(model_content, view = nil, content = nil)
	
		#model_content.merge('menu' => Menu.first)

		theme_root_path = "#{Rails.root}/themes/#{request.subdomain}/current_theme"
		theme_file = "/templates/#{view}.html.liquid"

		# Load the base theme file system for snippets to work
		Liquid::Template.file_system = Liquid::LocalFileSystem.new(theme_root_path)

		if File.exist?(theme_root_path + theme_file)
			content = File.read(theme_root_path + theme_file)
		else
			content = "No theme chosen yet for this subdomain"
		end

		#file_system = Liquid::LocalFileSystem.new(content)
		Liquid::Template.parse(content).render(model_content.merge('settings' => current_tenant), :filters => [LiquidFilters])
	end




end
