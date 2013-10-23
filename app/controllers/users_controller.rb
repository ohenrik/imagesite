class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def new 
		@user = User.new
	end

	def edit
	end

	def update
		if @user.update(params[:user])
			redirect_to edit_user_url, notice: "Success!"
		else
			render "edit"
		end
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			redirect_to root_url, notice: "Thank you for registering."
		else
			render "new"
		end
	end

	def destroy
		
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
