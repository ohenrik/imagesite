module ApplicationHelper



def liquidize(model_content)
content = File.read "#{Rails.root}/public/test/index.liquid"
#content = "This image is named " + @photo.name
  Liquid::Template.parse(content).render(model_content)
end


end
