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

end