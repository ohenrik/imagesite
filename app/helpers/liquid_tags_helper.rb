module LiquidTagsHelper


	class Random < Liquid::Tag
	  def initialize(tag_name, max, tokens)
	     super
	     @max = max.to_i
	  end

	  def render(context)
	    rand(@max).to_s
	  end
	end

	Liquid::Template.register_tag('random', Random)


	#
	# Header
	#
	class Header < Liquid::Tag
		def initialize(tag_name, markup, tokens)
			super

		end


	    def render(context)
	    	@path = Liquid::Template.file_system
	    	header_file = @path.root.to_s + "/layout/header.html.liquid"

	    	content = File.read(header_file)

	    	Liquid::Template.parse(content).render(context)
	    end

	end

	Liquid::Template.register_tag('header', Header)

	#
	# Footer
	#
	class Footer < Liquid::Tag
		def initialize(tag_name, markup, tokens)
			super

		end


	    def render(context)
	    	@path = Liquid::Template.file_system
	    	header_file = @path.root.to_s + "/layout/footer.html.liquid"

	    	content = File.read(header_file)

	    	Liquid::Template.parse(content).render(context)
	    end

	end

	Liquid::Template.register_tag('footer', Footer)

	#
	# CSS
	#
	class CssTag < Liquid::Tag

		# Include the stylesheet tag link helper
		include ActionView::Helpers::AssetTagHelper


		def initialize(tag_name, sheet, tokens)

			@sheet = sheet

			super
		end


	    def render(context)

	    	@path = Liquid::Template.file_system.root
	    	
	    	#derrive request subdomain from Liquid filesystem! 
	    	@path_array = @path.to_s.split("/")
	    	@subdomain = @path_array[-2]


	    	stylesheet_link_tag "/assets/#{@subdomain}/stylesheets/#{@sheet.strip}"
			
	    end

	end

	Liquid::Template.register_tag('css_tag', CssTag)


	#
	# image_tag
	#
	class ImageTag < Liquid::Tag

		# Include the stylesheet tag link helper
		include ActionView::Helpers::AssetTagHelper

		def initialize(tag_name, image_attributes, tokens)
			@image_attributes = image_attributes.tr('"', '').split(",")
			@image_path = @image_attributes[0]
			@alt = @image_attributes[1]
			@title = @image_attributes[2]
			@width = @image_attributes[3]
			@height = @image_attributes[4]
			super
		end

	    def render(context)

	    	@path = Liquid::Template.file_system.root
	    	
	    	#derrive request subdomain from Liquid filesystem! 
	    	@path_array = @path.to_s.split("/")
	    	@subdomain = @path_array[-2]

	    	image_tag("/assets/#{@subdomain}/images/#{@image_path.strip}", alt: @alt.strip, title: @title.strip, height: @height.try(:strip), width: @width.try(:strip))

	    end	

	end

	Liquid::Template.register_tag('image_tag', ImageTag)

end