class PasswordResetsController < ApplicationController


  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.try(:send_password_reset)
  	redirect_to root_url, :notice => "Email sent with password reset instrctions."
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		redirect_to new_password_reset_path, :alert => "Password reset has expired."
  	elsif @user.update_attributes(params[:password_reset])
  		redirect_to root_url, :notice => "Password reset successfull."
  	else
  		render :edit
  	end
  		
  end



private

	# Never trust parameters from the scary internet, only allow the white list through.
	#def user_reset_params
	#  params.require(:user).permit(:email, :password, :password_confirmation)
	#end

end
