module ApplicationHelper

	def link_to_add_fields(name, f, association, classes=nil)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
	  		render(association.to_s.singularize, f: builder)
		end
		link_to(name, '#', class: "add_fields #{classes}", data: {id: id, fields: fields.gsub("\n", "")})
	end

	def liquidize(model_content, layout_name = nil, template_name = nil)
	
		#model_content.merge('menu' => Menu.first)

		theme_root_path = "#{Rails.root}/themes/#{current_tenant.subdomain}/current_theme"

		# Load the base theme file system for snippets to work
		Liquid::Template.file_system = Liquid::LocalFileSystem.new(theme_root_path)

		if current_tenant.theme.present?
			if current_tenant.theme.code_files.find_by(:name => layout_name.to_s).present?
				layout_code = current_tenant.theme.code_files.find_by(:name => layout_name.to_s).code
			else
				layout_code = current_tenant.theme.code_files.where(hierarchy: 'layout').first.code
			end

			if current_tenant.theme.code_files.find_by(:name => template_name.to_s).present?
				template_code = current_tenant.theme.code_files.find_by(:name => template_name.to_s).code
			else
				template = current_tenant.theme.code_files.where(hierarchy: 'template', name: (controller.controller_name + "_" + controller.action_name + ".html" )).first
				template ||= current_tenant.theme.code_files.where(hierarchy: 'template', name: "pages_show.html").first
				template_code = template.try(:code)
			end

			templ = Liquid::Template.parse(template_code).render(model_content.merge('settings' => current_tenant, 'theme_id' => current_tenant.theme.id), :filters => [LiquidFilters])
			# Render the Layout file
			Liquid::Template.parse(layout_code).render(model_content.merge('template_content' => templ, 'settings' => current_tenant, 'theme_id' => current_tenant.theme.id), :filters => [LiquidFilters])

		else
			#content = "No theme chosen yet for this subdomain"
			layout_code = "No layout or theme chosen yet for this page"
			template_code = "No template chosen for the page yet"
			templ = Liquid::Template.parse(template_code).render(model_content.merge('settings' => current_tenant), :filters => [LiquidFilters])
			# Render the Layout file
			Liquid::Template.parse(layout_code).render(model_content.merge('template_content' => templ, 'settings' => current_tenant), :filters => [LiquidFilters])

		end

		#file_system = Liquid::LocalFileSystem.new(content)

		# Render the template file
	end



end

