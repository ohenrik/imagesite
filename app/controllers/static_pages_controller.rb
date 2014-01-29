class StaticPagesController < ApplicationController

	def home
		render layout: "app-container"
	end

	def user_home
		redirect_to controller: :photos, action: :index
	end

end