class Permission

	def initialize(user, subdomain)
		allow :static_pages, :home
		allow :users, [:new, :create]
		allow :sessions, [:new, :create, :destroy]
		allow :photos, [:list, :show]
		allow :tags, [:show]
		if user
			allow_param :user, [:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation]
			allow :users, [:edit, :update] do |inst|
				inst.id == user.id 
			end
		end
		if user && user.subdomain == subdomain
			allow_param :photo, [:name, :image, :edit_tag_list, :description]
			allow :photos, [:index, :new, :create, :edit, :update, :delete, :destroy]
			allow :tags, [:index, :new, :create, :edit, :update, :delete, :destroy]
		end
	end

	def allow?(controller, action, resource = nil)
		allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    	allowed && (allowed == true || resource && allowed.call(resource))
	end


		#	return true if controller.in?(%w[static_pages sessions])
		#return true if	controller == "photos" && action.in?(%w[show list])
		#return true if	controller == "static_pages" && action.in?(%w[home])
		#if !user.nil? && is_my_subdomain?(subdomain)
		#	return true if controller.in?(%w[photos tags]) && action.in?(%w[index new show list edit delete])
		#end

	def allow_all(controller, action)
		@allow_all = true
	end

	def allow(controllers, actions, &block)
		@allowed_actions ||= {}
		Array(controllers).each do |controller|
			Array(actions).each do |action|
				@allowed_actions[[controller.to_s, action.to_s]]  = block || true
			end
		end
	end

	  def allow_param(resources, attributes)
	    @allowed_params ||= {}
	    Array(resources).each do |resource|
	      @allowed_params[resource] ||= []
	      @allowed_params[resource] += Array(attributes)
	    end
	  end

	  def allow_param?(resource, attribute)
	    if @allow_all
	      true
	    elsif @allowed_params && @allowed_params[resource]
	      @allowed_params[resource].include? attribute
	    end
	  end


	  def permit_params!(params)
	    if @allow_all
	      params.permit!
	    elsif @allowed_params
	      @allowed_params.each do |resource, attributes|
	        if params[resource].respond_to? :permit
	          params[resource] = params[resource].permit(*attributes)
	        end
	      end
	    end
	  end

end