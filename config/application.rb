require File.expand_path('../boot', __FILE__)


require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)



module Imagesite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    

    
    
    config.autoload_paths += %W(#{config.root}/lib/assets)
    config.assets.precompile += %w( password_resets.js sessions.js users.js code_files.js galleries.js menu_items.js menus.js navigation.js page_items.js pages.js photos.js public_themes.js tags.js themes.js productions.js events.js offers.js customers.js tickets.js messages.js)
    # config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/cache"
    #config.assets.paths << "#{Rails.root}/public/uploads/themes/#{User.subdomain}/#{User.theme.id}/assets/stylesheets"
    #config.assets.paths << "#{Rails.root}/public/uploads/themes/#{User.subdomain}/#{User.theme.id}/assets/images"
    #config.assets.paths << "#{Rails.root}/public/uploads/themes/#{User.subdomain}/#{User.theme.id}/assets/javascripts"


    # We use a cookie_store for session data
    #config.session_store :cookie_store,
    #                     :key => '_imagesite_session',
    #                     :domain => ".imagesite.dev"
    
  end
end

