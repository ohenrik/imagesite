class Setting < RailsSettings::CachedSettings

	# Find the tenant
  around_filter :scope_current_tenant

  Setting.site_title
  Setting.site_tagline
  Setting.alias_domain
  Setting.home_controller
  Setting.home_action
  Setting.home_id

end
