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

		def initialize(tag_name, markup, tokens)

			super

		end


	    def render(context)
	    	@path = Liquid::Template.file_system
	    	header_file = @path.root.to_s + "/assets/style.css"

	    	#"<link rel='stylesheet' type='text/css' href='#{header_file}'>"
	    	content = File.read(header_file)



	    	#@path_array = @path.root.to_s.split('/')

	    	#@path_array.at(-3)

	    	#stylesheet_link_tag "#{@path_array.at(-3)}/#{@path_array.at(-2)}/theme_files/assets/style"
	    	#content = File.read(header_file)

	    	output = "<style>" + Liquid::Template.parse(content).render(context) + "</style>"
	    end

	end

	Liquid::Template.register_tag('css_tag', CssTag)

end