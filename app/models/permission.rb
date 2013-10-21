class Permission

	def initialize(user)
		allow :users, [:new, :create]
		allow :sessions, [:new, :create, :destroy]
		allow :photos, [:list, :show]
		allow :tags, [:show]
		if user
			allow :users, [:edit, :update]
			allow :photos, [:index, :new, :create, :edit, :update, :destroy]
			allow :tags, [:index, :new, :create, :edit, :update, :destroy]
		end
	end

	def allow?(controller, action, subdomain)
		return true if controller.in?(%w[static_pages sessions])
		return true if	controller == "photos" && action.in?(%w[show list])
		return true if	controller == "static_pages" && action.in?(%w[home])
		if !user.nil? && is_my_subdomain?(subdomain)
			return true if controller.in?(%w[photos tags]) && action.in?(%w[index new show list edit delete])
		end
	end

	def allow_all(controller, action)
		@allow_all = true
	end

	def allow(controllers, actions, subdomain)
		@allowed_actions ||= {}
		Array(controllers).each do |controller|
			Array(actions).each do |action|
				@allowed_actions[[controller.to_s, action.to_s]] = true
			end
		end
	end


	private

	def is_my_subdomain?(subdomain)
		if subdomain
			user.subdomain == subdomain
		end
	end
end