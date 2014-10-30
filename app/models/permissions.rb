module Permissions
  def self.permission_for(current_user, subdomain, host)
      if current_user.nil?
        GuestPermission.new
      elsif current_user.admin?
        AdminPermission.new
      elsif current_user.member?
        PremiumPermission.new(current_user, subdomain, host)
      elsif current_user.premium?
        MemberPermission.new(current_user, subdomain, host)
      elsif current_user.trail?
        
      end
  end
end
