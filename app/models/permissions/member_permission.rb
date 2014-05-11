module Permissions
	class MemberPermission < GuestPermission
		def initialize(user, subdomain, host)
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
				allow_param :page_item, [:position, :page_id, :pageable_id, :no_item_link, :design, :item_link, :item_class, :description, :title, :content, :pageable_type, :pageable, :gallery]
				allow_param :photo, [:name, :image, :edit_tag_list, :description]
				allow_param :page, [:name, :content, :excerpt, :status, :photo_id, :layout_name, :template_name]
				allow_param :theme, [:name, :thumbnail]
				allow_param :code_file, [:theme_id, :name, :display_name, :code, :hierarchy, :created_at, :updated_at, :static_file, :available_in => [], :available_to => []]
				allow_param :tag, [:name]
				allow_param :text, [:content]
				allow_param :page_title, [:title]
				allow :texts, [:show, :index, :new, :create, :add_to_page, :cancel_update, :edit, :update, :delete, :destroy ]
				allow :page_items, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :settings, :sort]
				allow :pages, [:index, :new, :create, :edit, :update, :delete, :destroy, :settings, :toggle_status, :add_to_page, :gallery_modal, :add_other_page_item, :set_thumbnail, :set_home, :add_to_menu]
				allow :photos, [:all, :new, :create, :edit, :update, :delete, :destroy, :add_to_page, :gallery_modal, :photo_manager_modal, :thumbnail_modal, :set_as_thumbnail]
				allow :tags, [:index, :new, :create, :edit, :update, :delete, :destroy, :add_to_menu]
				allow :menus, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :add_item_to_menu]
				allow :menu_items, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :sort]
				allow :themes, [:show, :index, :edit, :update, :create, :new, :destroy, :select_theme, :publish_theme, :install_theme, :public_index, :public_destroy]
				allow :code_files, [:show, :index, :edit, :update, :create, :new, :destroy, :public_index, :public_edit]
			end
			super()
		end
	end
end