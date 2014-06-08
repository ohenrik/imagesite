class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include UrlHelper
	before_filter :authorize

	#enable to check for allowed action
	delegate :allow?, to: :current_permission
	helper_method :allow?

	delegate :allow_param?, to: :current_permission
	helper_method :allow_param?

private

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
		
		@current_tenant ||= User.find_by!(subdomain: request.subdomain) # includes(:home).
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
		%w(lvh.me theatrical.co theatrical.no theatrical.de).include?(request.domain) ? current_user.subdomain : ""
	end
	helper_method :get_subdomain

	def referer
	  env['HTTP_REFERER'] || '/'
	end
	helper_method :referer

end
