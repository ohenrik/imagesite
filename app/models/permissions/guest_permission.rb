module Permissions
	class GuestPermission < BasePermission
		def initialize()
			# People
			allow :people, [:show]

			# Pages
			allow :pages, [:show]

			# Photos
			allow :photos, [:index, :show]

			# Event
			allow :events, [:show]

			# Users
			allow :users, [:new, :create, :home, :confirm_user]
			allow_param :user, [:first_name, :last_name, :username, :subdomain, :email, :password, :password_confirmation]

			# Sessions and user resets
			allow :sessions, [:new, :create, :destroy]
			allow :password_resets, [:new, :create, :update, :edit]
			allow_param :password_reset, [:email, :password, :password_confirmation]

			# Tags
			allow :tags, [:show]

			# Static pages
			allow :static_pages, [:home, :navigation, :user_home]

			# Code Files
			allow :code_files, [:show]

		end
	end
end