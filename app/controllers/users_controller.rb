class UsersController < ApplicationController


	# Find the tenant
	# All users are in the public scema, hover all other date linked through assosiations need the tenant scema.
	# So when the users home screen is requested the user must have schema = "tenant1,public"
  	around_filter :scope_current_tenant, only: [:home]


	before_action :set_user, only: [:show, :edit, :update, :destroy, :settings, :set_base_theme]
	after_action :set_base_theme, only: [:create]

	before_action :add_alias_domain, only: [:update]

	def new 
		@user = User.new
	end

	def setting

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
			redirect_to photos_path
		end

	end

	def edit
	end

	def update
		if @user.update(params[:user])
			redirect_to edit_user_url, notice: "Success! Information saved. Thank you!"
		else
			render "edit"
		end
	end

	def create 
		@user = User.new(params[:user])
		@user.roles << Role.find_by_role("member")
		if @user.save
			redirect_to root_url, notice: "Thank you for registering."
		else
			render "new"
		end
	end

	def set_base_theme
		# Scope correct tenant
		connection = @user.connection
		original_search_path = connection.schema_search_path
		connection.schema_search_path = "tenant#{@user.id},public"

		base_theme_url = Rails.root.join('base_theme', 'base_theme.zip')
		@theme = Theme.new(name: "Morgenstern", user_id: @user.id)
		@theme.zip = File.open(base_theme_url)
		@theme.save

		@theme.extract_preview

		# Activate the Theme
		@user.theme_id = @theme.id
		@user.save
		
		@theme.extract_theme
		@theme.precompile_theme_assets

		connection.schema_search_path = original_search_path
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

	def add_alias_domain
		if current_user.alias_domain != params[:user][:alias_domain]
			
		end
	end


	## Moved string parametres into permitt class
	# Never trust parameters from the scary internet, only allow the white list through.
	#def user_params
	#  params.require(:user).permit(:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation)
	#end

end
