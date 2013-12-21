class Permission

	def initialize(user, subdomain)
		allow :static_pages, [:home, :navigation]
		allow :users, [:new, :create]
		allow :password_resets, [:new, :create, :update, :edit]
		allow_param :password_reset, [:email, :password, :password_confirmation]
		allow_param :user, [:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation]
		allow :sessions, [:new, :create, :destroy]
		allow :photos, [:index, :show]
		allow :tags, [:show]
		if user
			allow :users, [:edit, :update] do |inst|
				inst.id == user.id
			end
		end
		if user && user.subdomain == subdomain
			allow_param :user, [:current_theme]
			allow_param :menu, [:name, :menu_item_id]
			allow_param :menu_item, [:menu_id, :menuable_id, :menuable_type, :name, :description, :new_page, :ancestry]
			allow_param :photo, [:name, :image, :edit_tag_list, :description]
			allow_param :page, [:title, :content, :excerpt, :status, :photo_id]
			allow :pages, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :set_thumbnail, :add_to_menu]
			allow :photos, [:all, :new, :create, :edit, :update, :delete, :destroy]
			allow :tags, [:index, :new, :create, :edit, :update, :delete, :destroy, :add_to_menu]
			allow :menus, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :add_item_to_menu]
			allow :menu_items, [:index, :show, :new, :create, :edit, :update, :delete, :destroy]
			allow :themes, [:show, :index, :edit, :update, :create, :new, :destroy, :select_theme]
			allow_param :theme, [:zip, :name]
		end
	end


	def allow?(controller, action, resource = nil)
		allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    	allowed && (allowed == true || resource && allowed.call(resource))
	end

	def allow_all
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