module Permissions
	class DeveloperPermission < PremiumPermission
		def initialize(current_user, subdomain, host)
			
			super
		end
	end
end