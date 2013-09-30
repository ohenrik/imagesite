class UsersController < ApplicationController

	before_filter :authorize, except: [:new, :create]

	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def new 
		@user = User.new
	end

	def create 
		@user = User.new(user_params)
		if @user.save
			redirect_to root_url, notice: "Thank you for registering."
		else
			render "new"
		end
	end

	def destroy
		
	end


private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
	  @user = User.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
	  params.require(:user).permit(:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation)
	end

end
