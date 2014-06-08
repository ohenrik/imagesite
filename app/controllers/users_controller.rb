require "net/https"
require "uri"
class UsersController < ApplicationController


	# Find the tenant
	# All users are in the public scema, hover all other date linked through assosiations need the tenant scema.
	# So when the users home screen is requested the user must have schema = "tenant1,public"
  	around_filter :scope_current_tenant, only: [:home]


	before_action :set_user, only: [:show, :edit, :update, :destroy, :settings, :update_settings, :set_base_theme, :edit_alias_domain, :set_alias_domain ,:remove_alias_domain]
	#after_action :set_base_theme, only: [:create]


	def index
		@users = User.all
	end

	def new 
		@user = User.new
	end

	def setting

	end

	def confirm_user
		@user = User.find_by(confirm_email_token: params[:token])
		@user.confirmed_email_at = Time.zone.now
		CreateClientWorker.perform_async(@user.id)
		@user.save!
		redirect_to login_url, notice: "#{@user.email} is now confirmed. You can now log in!"
	end

	def home
		# Multitenant rails app. This refers to user who owns the subdomain visited.
		@user = current_tenant

		# This is not optimal, results in two queries.
		if @user.home_id.present? && @user.home_type.classify.constantize.exists?(@user.home_id)

			# This is the same as @page = Page.find(params[:id])
			instance_variable_set("@#{@user.home_type.downcase}", @user.home_type.classify.constantize.find(@user.home_id))

			# this is the same as render 'pages/show', layout: false
			render "#{@user.home_type.downcase.pluralize}/show", layout: false
		else
			redirect_to pages_path, notice: "No front page selected. Please select a page or create a new front page."
		end

	end

	def edit
	end

	def update
		if params[:paymillToken]
			@user.add_credit_card(params[:paymillToken])
		end
		if @user.update(params[:user])
			redirect_to edit_user_url, notice: "Success! Information saved. Thank you!"
		else
			render "edit"
		end
	end

	def update_settings
		if @user.update(params[:user])
			redirect_to settings_url, notice: "Success! Information saved. Thank you!"
		else
			render "settings"
		end
	end

	def edit_alias_domain

	end  
	# DELETE /pages/1
	# DELETE /pages/1.json
	def destroy
		@user.destroy
		redirect_to home_url
  	end

	def set_alias_domain
		# Url for adding 
		uri = URI.parse("https://api.digitalocean.com/domains/new?client_id=#{ENV['do_client_id']}&api_key=#{ENV['do_key']}&name=#{(params[:user][:alias_domain]).html_safe}&ip_address=95.85.20.208")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		response.body
		@resp = JSON.parse(response.body)
		if @resp['status'] == 'OK'
			if @user.update(params[:user])
				redirect_to settings_url, notice: "#{@resp['domain']['name']} is now your new alias domain."
			else
				redirect_to settings_url, alert: "Error, new domain not saved correctly. Contact support or remove the domain and try again"
			end
		else
			redirect_to settings_url, alert: "Error, new domain not set. Contact support"
		end
	end

	def remove_alias_domain
		# Url for removing
		uri = URI.parse("https://api.digitalocean.com/domains/#{@user.alias_domain}/destroy?client_id=#{ENV['do_client_id']}&api_key=#{ENV['do_key']}")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		response.body
		@resp = JSON.parse(response.body)
		if @resp['status'] == 'OK'
			@user.alias_domain = nil
			if @user.update(params[:user])
				redirect_to settings_url, notice: "Alias domain is now removed"
			else
				redirect_to settings_url, alert: "Error, alias domain not removed correctly. Contact support."
			end
		else
			redirect_to settings_url, alert: "Error, domain not removed. Contact support"
		end
	end

	def create 
		@user = User.new(params[:user])
		@user.roles << Role.find_by_role("member")
		@user.subdomain = @user.subdomain.downcase
		if @user.save
			NewUserMailWorker.perform_async(@user.id)
			CreateSchemaWorker.perform_async(@user.id)
			redirect_to root_url, notice: "Thank you for registering."
		else
			render "new"
		end
	end

	def set_base_theme
		# Scope correct tenant
		#connection = @user.connection
		#original_search_path = connection.schema_search_path
		#connection.schema_search_path = "tenant#{@user.id},public"

		#base_theme_url = Rails.root.join('base_theme', 'base_theme.zip')
		#@theme = Theme.new(name: "Morgenstern", user_id: @user.id)
		#@theme.zip = File.open(base_theme_url)
		#@theme.save

		#@theme.extract_preview

		## Activate the Theme
		#@user.theme_id = @theme.id
		#@user.save
		#
		#@theme.extract_theme
		#@theme.precompile_theme_assets

		#connection.schema_search_path = original_search_path
	end

	def destroy

		# Destroy the Roles assosiations to this user in the join table.
		# user.roles.clear


		# Destroy the user details
		
	end

	def current_resource
	  @current_resource ||= User.find(params[:id]) if params[:id]
	end



private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
	  @user = User.find(params[:id])
	end

	## Moved string parametres into permitt class
	# Never trust parameters from the scary internet, only allow the white list through.
	#def user_params
	#  params.require(:user).permit(:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation)
	#end

end
