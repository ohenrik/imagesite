class UsersController < ApplicationController


	# Find the tenant
	# All users are in the public scema, hover all other date linked through assosiations need the tenant scema
  	around_filter :scope_current_tenant


	before_action :set_user, only: [:show, :edit, :update, :destroy, :settings]

	def new 
		@user = User.new
	end

	def setting

	end

	def home
		@user = current_tenant

		@page = @user.home_type.classify.constantize.find(@user.home_id)
		render 'pages/show', layout: false
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
