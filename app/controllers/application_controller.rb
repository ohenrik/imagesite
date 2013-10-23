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
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end
	helper_method :current_user

	def current_permission
	  @current_permission ||= Permission.new(current_user, request.subdomain)
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
		@current_tenant ||= User.find_by_subdomain!(request.subdomain)
	end
	helper_method :current_tenant

	def scope_current_tenant(&block)
		if request.subdomain.present? && !%w(subdomain www).include?(request.subdomain)
			current_tenant.scope_schema("public", &block)
		else
			redirect_to login_url(:subdomain => false)
		end
	end
	helper_method :scope_current_tenant


end
