class Permission < Struct.new(:user)

	def allow?(controller, action, subdomain)
		return true if controller.in?(%w[static_pages sessions])
		return true if	controller == "photos" && action.in?(%w[show list])
		return true if	controller == "static_pages" && action.in?(%w[home])
		if !user.nil? && is_my_subdomain?(subdomain)
			return true if controller.in?(%w[photos tags]) && action.in?(%w[index new show list edit delete])
		end
	end


	private

	def is_my_subdomain?(subdomain)
		if subdomain
			user.subdomain == subdomain
		end
	end
end