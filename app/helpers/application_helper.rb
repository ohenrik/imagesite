module ApplicationHelper

	def liquidize(model_content, layout_id = nil, template_id = nil)
	
		#model_content.merge('menu' => Menu.first)

		theme_root_path = "#{Rails.root}/themes/#{current_tenant.subdomain}/current_theme"

		# Load the base theme file system for snippets to work
		Liquid::Template.file_system = Liquid::LocalFileSystem.new(theme_root_path)

		if current_tenant.theme.present?
			if layout_id
				layout_code = current_tenant.theme.code_files.find(layout_id).code
			else
				layout_code = current_tenant.theme.code_files.where(hierarchy: 'layout').first.code
			end

			if template_id
				template_code = current_tenant.theme.code_files.find(template_id).code
			else
				template_code = current_tenant.theme.code_files.where(hierarchy: 'template', name: (controller.controller_name + "_" + controller.action_name + ".html" )).first.code
			end
		else
			#content = "No theme chosen yet for this subdomain"
			layout_code = "No layout or theme chosen yet for this page"
			template_code = "No template chosen for the page yet"
		end

		#file_system = Liquid::LocalFileSystem.new(content)

		# Render the template file
		templ = Liquid::Template.parse(template_code).render(model_content.merge('settings' => current_tenant, 'theme_id' => current_tenant.theme.id), :filters => [LiquidFilters])
		# Render the Layout file
		Liquid::Template.parse(layout_code).render(model_content.merge('template_content' => templ, 'settings' => current_tenant, 'theme_id' => current_tenant.theme.id), :filters => [LiquidFilters])
	end



end

