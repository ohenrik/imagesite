module Permissions
  class AdminPermission < BasePermission
    def initialize
      allow_all
    end
  end
end