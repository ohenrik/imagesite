class Setting < RailsSettings::CachedSettings

	# Find the tenant
  around_filter :scope_current_tenant

  
end
