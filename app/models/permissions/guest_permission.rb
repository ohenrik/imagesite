module Permissions
	class GuestPermission < BasePermission
		def initialize()
			allow :static_pages, [:home, :navigation, :user_home]
			allow :users, [:new, :create, :home, :confirm_user]
			allow :password_resets, [:new, :create, :update, :edit]
			allow_param :password_reset, [:email, :password, :password_confirmation]
			allow_param :user, [:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation]
			allow :sessions, [:new, :create, :destroy]
			allow :photos, [:index, :show]
			allow :tags, [:show]
			allow :pages, [:show]
			allow :code_files, [:show]
			allow :public_code_files, [:show, :index, :edit, :update, :new, :create, :delete, :destroy]
			allow :public_themes, [:index, :show, :edit, :update, :new, :create, :delete, :destroy]
			allow_param :public_theme, [:name, :thumbnail]
			allow_param :public_code_file, [:theme_id, :name, :display_name, :code, :hierarchy, :created_at, :updated_at, :static_file, :available_in => [], :available_to => []]
		end
	end
end