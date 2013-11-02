module ApplicationHelper



def liquidize(model_content, view = nil, content = nil)
	
	content = File.read "#{Rails.root}/public/themes/basic/templates/#{view}.liquid" if view != nil
	
	Liquid::Template.parse(content).render(model_content)

end


end
