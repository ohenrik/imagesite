module ApplicationHelper

	def liquidize(model_content, layout_id = nil, template_id = nil)
	
		#model_content.merge('menu' => Menu.first)

		theme_root_path = "#{Rails.root}/themes/#{current_tenant.subdomain}/current_theme"

		# Load the base theme file system for snippets to work
		Liquid::Template.file_system = Liquid::LocalFileSystem.new(theme_root_path)

		if current_tenant.theme.present?

			layout_code = current_tenant.theme.code_files.find(layout_id).code
			template_code = current_tenant.theme.code_files.find(template_id).code
		else
			#content = "No theme chosen yet for this subdomain"
			layout_code = "No layout or theme chosen yet for this page"
			template_code = "No template chosen for the page yet"
		end

		#file_system = Liquid::LocalFileSystem.new(content)

		# Render the template file
		templ = Liquid::Template.parse(template_code).render(model_content.merge('settings' => current_tenant), :filters => [LiquidFilters])
		# Render the Layout file
		Liquid::Template.parse(layout_code).render(model_content.merge('template_content' => templ, 'settings' => current_tenant), :filters => [LiquidFilters])
	end

	def current_tenant
		@current_tenant ||= User.find_by_alias_domain(request.host)
		@current_tenant ||= User.find_by_subdomain!(request.subdomain) # includes(:home).
	end


end

