class Permission < Struct.new(:user)

	def allow?(controller, action)
		controller == "photos" && action == "index"
	end

end