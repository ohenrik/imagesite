class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :scope_current_tenant

private

	def current_user
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end
	helper_method :current_user

	def authorize
		redirect_to login_url, alert: "Not Authorized" if current_user.nil?
	end

	def authorized?
		return false if current_user.nil?
		return true
	end

	def current_tenant
		@current_tenant ||= User.find_by_subdomain!(request.subdomain)
	end
	helper_method :current_tenant

	def scope_current_tenant(&block)
		current_tenant.scope_schema("public", &block)
	end

end
