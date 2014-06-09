Sidekiq.configure_server do |config|
  config.redis = { url:       'redis://localhost:6379/0',
                   namespace: "sidekiq_#{Rails.application.class.parent_name}_#{Rails.env}".downcase }
end

Sidekiq.configure_client do |config|
  config.redis = { url:       'redis://localhost:6379/0',
                   namespace: "sidekiq_#{Rails.application.class.parent_name}_#{Rails.env}".downcase }
end