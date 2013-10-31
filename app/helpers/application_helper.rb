module ApplicationHelper



def liquidize(model_content, view = nil)
content = File.read "#{Rails.root}/public/test/#{view}.liquid"
#content = "This image is named " + @photo.name
  Liquid::Template.parse(content).render(model_content)
end


end
