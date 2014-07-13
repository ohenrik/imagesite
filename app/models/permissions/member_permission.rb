module Permissions
	class MemberPermission < GuestPermission
		def initialize(user, subdomain, host)
			if user
				allow :users, [:edit, :update, :settings, :update_settings, :edit_alias_domain, :set_alias_domain ,:remove_alias_domain] do |inst|
					inst.id == user.id
				end
				allow_param :user, [:current_theme, :site_title, :site_tagline, :alias_domain, :home_type, :home_id]
			end
			# This checks to see if the user is loged in with the account he is trying to edit
			if user && ((user.subdomain == subdomain) or (user.alias_domain == host))
				# Person
				allow :people, [:index, :show, :new, :create, :edit, :update, :destroy, :gallery_modal, :add_to_page, :add_to_menu]
				allow_param :person, [:first_name, :last_name, :title, :description, :email, :phone, :mobile_phone, :photo_id] 

				# Page
				allow :pages, [:index, :new, :create, :edit, :update, :delete, :destroy, :settings, :toggle_status, :add_to_page, :gallery_modal, :add_other_page_item, :set_thumbnail, :set_home, :add_to_menu]
				allow_param :page, [:name, :content, :excerpt, :status, :photo_id, :layout_name, :template_name]

				# Page Item
				allow :page_items, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :settings, :sort]
				allow_param :page_item, [:position, :page_id, :pageable_id, :no_item_link, :design, :item_link, :item_class, :description, :title, :content, :pageable_type, :pageable, :gallery]


				# Photo
				allow :photos, [:all, :new, :create, :edit, :update, :destroy, :add_to_page, :gallery_modal, :photo_manager_modal, :thumbnail_modal, :set_as_thumbnail, :remove_thumbnail]
				allow_param :photo, [:name, :image, :edit_tag_list, :description]

				# Tag
				allow :tags, [:index, :new, :create, :edit, :update, :delete, :destroy, :add_to_menu]
				allow_param :tag, [:name]

				# Menu
				allow :menus, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :add_item_to_menu]
				allow_param :menu, [:name, :menu_item_id, :slug]

				# Menu item
				allow :menu_items, [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :sort]
				allow_param :menu_item, [:menu_id, :menuable_id, :menuable_type, :name, :description, :new_page, :ancestry, :position, :url]



				# Tickets
				allow :customers, [:index, :show, :new, :create, :edit, :update, :delete, :destroy]
				allow_param :customer, [:name, :price, :currency, :offer_id, :customer_id]

				# Offer
				allow :offers, [:new, :create, :edit, :update, :destroy]
				offer_attributes = [:name, :price, :currency, :capacity, :offerable_id, :offerable_type] 
				allow_param :offer, offer_attributes

				# Customers
				allow :customers, [:index, :show, :new, :create, :edit, :update, :delete, :destroy]
				allow_param :customer, [:first_name, :last_name, :email]

				# Event
				allow :events, [:new, :index, :create, :edit, :update, :destroy, :gallery_modal, :add_to_page, :add_to_menu]
				offer_attributes << [:id, :_destroy]
				event_attributes = [:name, :description, :venue, :capacity, :address, :status, :start_date, :end_date, :start_time, :end_time, :photo_id, offers_attributes: offer_attributes]
				allow_param :event, event_attributes

				# Production
				allow :productions, [:new, :index, :create, :edit, :update, :destroy, :add_to_page, :gallery_modal, :add_to_menu]
				event_attributes << [:id, :_destroy]
				allow_param :production, [:name, :photo_id, :description, events_attributes: event_attributes] 



				# Theme
				allow :themes, [:show, :index, :edit, :update, :create, :new, :destroy, :select_theme, :publish_theme, :install_theme, :public_index, :public_destroy]
				allow_param :theme, [:name, :thumbnail]

				# Code_file
				allow :code_files, [:show, :index, :edit, :update, :create, :new, :destroy, :public_index, :public_edit]
				allow_param :code_file, [:theme_id, :name, :display_name, :code, :hierarchy, :created_at, :updated_at, :static_file, :available_in => [], :available_to => []]

			end
			super()
		end
	end
end