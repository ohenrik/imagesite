# Production
set :domain, "theatrical.co"
set :application, "imagesite"
set :deploy_to, "/home/rails/apps/#{application}"
set :branch, 'master'



server domain, :app, :web
role :web, domain, :primary => true
role :app, domain, :primary => true
role :db, domain, :primary => true
set :use_sudo, false

default_run_options[:pty] = true
