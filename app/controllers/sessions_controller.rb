class SessionsController < ApplicationController


  def new

  end

  def create
  	user = User.find_by_username(params[:username])
    user ||= User.find_by_email(params[:username])
  	if user && user.authenticate(params[:password])
      # session[:user_id] = user.id
  		if params[:remember_me]
        cookies.permanent[:auth_token] = { value: user.auth_token, domain: "."+request.domain }
      else
        cookies[:auth_token] = { value: user.auth_token, domain: "."+request.domain }
      end
  		redirect_to pages_url(:subdomain => "#{get_subdomain}"), notice: "You are now loged in."
  	else
  		flash.now.alert = "Email or password is invalid"
  		render "new"
  	end
  end

  def destroy
  	#session[:user_id] = nil
    cookies.delete(:auth_token, :domain => "."+request.domain )
  	redirect_to root_url(:subdomain => false), notice: "Loged out"
  end

private
	# Use callbacks to share common setup or constraints between actions.
	def set_session
	  
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def session_params
	  params.require(:session).permit(:username, :email, :password)
	end

end
