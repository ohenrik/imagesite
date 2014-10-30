class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  
  before_action :set_cart, only: [:liquidize]

  include UrlHelper
  before_filter :authorize

  #enable to check for allowed action
  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?

private


    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

  def current_user
    @current_user ||= User.find_by!(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def current_permission
    @current_permission ||= Permissions.permission_for(current_user, request.subdomain, request.host)
  end

  def current_resource
    nil
  end

  def authorize
    if current_permission.allow?(params[:controller], params[:action], current_resource)
      current_permission.permit_params! params  
    else
      redirect_to login_url, alert: "Not Authorized."
    end
  end

  def current_tenant
    @current_tenant = User.find_by(alias_domain: request.host) unless %w(lvh.me theatrical.co theatrical.no theatrical.de).include?(request.domain)
    
    @current_tenant ||= User.find_by(subdomain: request.subdomain) # includes(:home).
  end
  helper_method :current_tenant

  def scope_current_tenant(&block)
    if (request.subdomain.present? or !%w(lvh.me theatrical.co theatrical.no theatrical.de).include?(request.domain)) && !%w(subdomain www).include?(request.subdomain)
      current_tenant.scope_schema("public", &block)
    else
      redirect_to login_url(:subdomain => false), alert: "Error scoping current tenant"
    end
  end
  helper_method :scope_current_tenant

  def get_subdomain
    subdomain = current_tenant.try(:subdomain) || current_user.subdomain
    %w(lvh.me theatrical.co theatrical.no theatrical.de).include?(request.domain) ? subdomain : ""
  end
  helper_method :get_subdomain

  def referer
    env['HTTP_REFERER'] || '/'
  end
  helper_method :referer



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
        template = current_tenant.theme.code_files.where(hierarchy: 'template', name: (self.controller_name + "_" + self.action_name + ".html" )).first
        template ||= current_tenant.theme.code_files.where(hierarchy: 'template', name: "pages_show.html").first
        template_code = template.try(:code)
      end

      templ = Liquid::Template.parse(template_code).render(model_content.merge('settings' => current_tenant, 'theme_id' => current_tenant.theme.id, 'cart' => set_cart), registers: {controller: self}, :filters => [LiquidFilters])
      # Render the Layout file

      Liquid::Template.parse(layout_code).render(model_content.merge('template_content' => templ, 'settings' => current_tenant, 'theme_id' => current_tenant.theme.id, 'cart' => set_cart), registers: {controller: self}, :filters => [LiquidFilters])

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
    helper_method :liquidize



end
