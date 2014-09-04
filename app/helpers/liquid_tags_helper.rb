module LiquidTagsHelper


  class Param < ::Liquid::Tag

    def render(context)
      controller = context.registers[:controller]
      name = controller.send(:request_forgery_protection_token).to_s
      value = controller.send(:form_authenticity_token)

      %(<input type="hidden" name="#{name}" value="#{value}">)
    end

  end

  Liquid::Template.register_tag('csrf_param', Param)


  class Meta < ::Liquid::Tag

    def render(context)
      controller = context.registers[:controller]
      name = controller.send(:request_forgery_protection_token).to_s
      value = controller.send(:form_authenticity_token)

      %{
          <meta name="csrf-param" content="#{name}">
          <meta name="csrf-token" content="#{value}">
        }
    end

  end

  Liquid::Template.register_tag('csrf_meta', Meta)


  class JqueryTag < ::Liquid::Tag
    # Include the stylesheet tag link helper
    include ActionView::Helpers::AssetTagHelper


    def render(context)
      return javascript_include_tag("/assets/jquery")
    end

  end

  Liquid::Template.register_tag('jquery_tag', JqueryTag)

  class UjsTag < ::Liquid::Tag
    # Include the stylesheet tag link helper
    include ActionView::Helpers::AssetTagHelper


    def render(context)
      return javascript_include_tag("/assets/jquery_ujs")

    end

  end

  Liquid::Template.register_tag('jquery_ujs_tag', UjsTag)


  class LinkTag < Liquid::Block

    #include ActionView::Context
    include ActionView::Helpers::UrlHelper
    attr_accessor :output_buffer

    def initialize(tag_name, markup, tokens)
      super

      @markup = markup
      @attributes = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key.to_sym] = value.gsub!(/^\"|\"?$/, '').gsub!(/^\'|\'?$/, '')
        # for stripping qoutes use .gsub!(/^\"|\"?$/, '').gsub!(/^\'|\'?$/, '')
      end

    end

    def render(context)
      method = @attributes[:url] || :get
      link_to(remove_quotes(@attributes[:url]), method: method, class: remove_quotes(@attributes[:class]), title: @attributes[:title]) do
        #<a href="/line_items" data-method="post" title="Add to Cart">
        super(context).html_safe

      end
    end

    def remove_quotes(string)
      string ? string.gsub!(/^\"|\"?$/, '').gsub!(/^\'|\'?$/, '') : nil
    end

  end

  Liquid::Template.register_tag('link_to', LinkTag)

  #
  # Partials
  #
  class SnippetFile < Liquid::Tag
    # Include the stylesheet tag link helper
    include ActionView::Helpers::AssetTagHelper

    def initialize(tag_name, variables, tokens)
      @variables = variables.split(" ")


      @default_name = @variables[0]
      @file_name = @variables[1]

      super
    end

    def render(context)

      if @file_name.present? && (context[@file_name.strip]).present?
        content = CodeFile.find_by(hierarchy: 'snippet', name: context[@file_name.strip], theme_id: context["theme_id"])
      else
        content = CodeFile.find_by(hierarchy: 'snippet', name: @default_name, theme_id: context["theme_id"])
      end

      Liquid::Template.parse(content.code).render(context)

    end


  end

  Liquid::Template.register_tag('snippet_file', SnippetFile)


  #
  # Static_asset
  #
  class AssetPath < Liquid::Tag

    # Include the stylesheet tag link helper
    include ActionView::Helpers::AssetTagHelper

    def initialize(tag_name, variables, tokens)
      @variables = variables.split(" ")

      @file_name = @variables[0]

      super
    end


    def render(context)

      #asset = CodeFile.find_by!(hierarchy: 'asset', name: @file_name.to_s, theme_id: context["theme_id"])

      "/themes/#{context["theme_id"]}/code_files/#{@file_name.strip}"

    end

  end

  Liquid::Template.register_tag('asset_path', AssetPath)


  #
  # CSS
  #
  class CssTag < Liquid::Tag

    # Include the stylesheet tag link helper
    include ActionView::Helpers::AssetTagHelper

    def initialize(tag_name, variables, tokens)
      @variables = variables.split(" ")

      @file_name = @variables[0]

      super
    end


    def render(context)

      #sheet = CodeFile.find_by!(hierarchy: 'asset', name: @file_name.to_s, theme_id: context["settings.theme.id"])

      stylesheet_link_tag "/themes/#{context["theme_id"]}/code_files/#{@file_name.strip}"

    end

  end

  Liquid::Template.register_tag('css_tag', CssTag)


  #
  # CSS
  #
  class JavaScriptiTag < Liquid::Tag

    # Include the stylesheet tag link helper
    include ActionView::Helpers::AssetTagHelper

    def initialize(tag_name, variables, tokens)
      @variables = variables.split(" ")

      @file_name = @variables[0]

      super
    end


    def render(context)

      #sheet = CodeFile.find_by!(hierarchy: 'asset', name: @file_name.to_s, theme_id: context["theme_id"])

      javascript_include_tag "/themes/#{context["theme_id"]}/code_files/#{@file_name.strip}"

    end

  end

  Liquid::Template.register_tag('javascript_tag', JavaScriptiTag)


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


  #
  # CSS
  #

  class GetMenu < Liquid::Tag
    include ApplicationHelper

    def initialize(tag_name, variables, tokens)

      @variables = variables.split(" ")

      @menu_object = @variables[0]
      @file_name = @variables[1]

      super
    end

    def render(context)

      content = CodeFile.find_by(hierarchy: 'snippet', name: @file_name.to_s, theme_id: context["theme_id"])

      @menu ||= Menu.find_by_slug(@menu_object)

      context.merge('menu' => @menu)

      Liquid::Template.parse(content.code).render(context)

    end

  end

  Liquid::Template.register_tag('get_menu', GetMenu)




  class FormTag < Liquid::Block

    attr_reader :controller

    include ActionView::Helpers::FormTagHelper
    include ActionView::Context
    include AbstractController::Helpers


    def initialize(tag_name, markup, tokens)
      super

      @markup = markup
      @attributes = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key.to_sym] = value
        # for stripping qoutes use .gsub!(/^\"|\"?$/, '').gsub!(/^\'|\'?$/, '')
      end

    end

    def render(context)
      @controller = context.registers[:controller]

      form_tag(remove_quotes(@attributes[:url]), class: remove_quotes(@attributes[:class])) do
        super(context).html_safe
      end
    end

    def remove_quotes(string)
      string ? string.gsub!(/^\"|\"?$/, '').gsub!(/^\'|\'?$/, '') : nil
    end

  end

  Liquid::Template.register_tag('form', FormTag)

end

# Important for form CSRF, making controller available
Liquid::Block.class_eval do
  # This delegates missing - including private & protected - methods (like protect_against_forgery?) to controller.
  def method_missing(*args)
    begin
      if controller.respond_to?(args.first, true)
        controller.send(args.first)
      else
        super
      end
    rescue
      super
    end
  end
end





