class Permission

	def initialize(user, subdomain, host)
		allow :static_pages, [:home, :navigation, :user_home]
		allow :users, [:new, :create, :home]
		allow :password_resets, [:new, :create, :update, :edit]
		allow_param :password_reset, [:email, :password, :password_confirmation]
		allow_param :user, [:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation]
		allow :sessions, [:new, :create, :destroy]
		allow :photos, [:index, :show]
		allow :tags, [:show]
		allow :pages, [:show]
		if user
			allow :users, [:edit, :update, :settings, :update_settings, :edit_alias_domain, :set_alias_domain ,:remove_alias_domain] do |inst|
				inst.id == user.id
			end
		end
		# This checks to see if the user is loged in with the account he is trying to edit
		if user && ((user.subdomain == subdomain) or (user.alias_domain == host))
			allow_param :user, [:current_theme, :site_title, :site_tagline, :alias_domain, :home_type, :home_id]
			allow_param :menu, [:name, :menu_item_id, :slug]
			allow_param :menu_item, [:menu_id, :menuable_id, :menuable_type, :name, :description, :new_page, :ancestry, :position, :url]
			allow_param :page_item, [:position, :page_id, :pageable_id, :no_item_link, :item_link, :item_class, :description, :title, :content, :pageable_type, :pageable, :gallery]
			allow_param :photo, [:name, :image, :edit_tag_list, :description]
			allow_param :page, [:name, :content, :excerpt, :status, :photo_id]
			allow_param :theme, [:zip, :name]
			allow_param :tag, [:name]
			allow_param :text, [:content]
			allow_param :page_title, [:title]
			allow :texts, [:show, :index, :new, :create, :add_to_page, :cancel_update, :edit, :update, :delete, :destroy ]
			allow :page_titles, [:show, :index, :new, :create, :add_to_page, :cancel_update, :edit, :update, :delete, :destroy ]
			allow :page_items, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :settings, :sort]
			allow :pages, [:index, :new, :create, :edit, :update, :delete, :destroy, :settings, :toggle_status, :add_to_page, :gallery_modal, :add_gallery, :set_thumbnail, :set_home, :add_to_menu]
			allow :photos, [:all, :new, :create, :edit, :update, :delete, :destroy, :add_to_page, :gallery_modal, :photo_manager_modal, :thumbnail_modal, :set_as_thumbnail]
			allow :tags, [:index, :new, :create, :edit, :update, :delete, :destroy, :add_to_menu]
			allow :menus, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :add_item_to_menu]
			allow :menu_items, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :sort]
			allow :themes, [:show, :index, :edit, :update, :create, :new, :destroy, :select_theme]
			allow :public_themes, [:index, :show]
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