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
		include ActionDispatch::Http::URL


		def initialize(tag_name, markup, tokens)

			user = Rails.root

			super
		end


	    def render(context)

	    	@path = Liquid::Template.file_system
	    	css_file = "style.css"
	    	

	    	stylesheet_link_tag "/assets/#{subdomain}/javascripts/style.css"

	    end

	end

	Liquid::Template.register_tag('css_tag', CssTag)

end