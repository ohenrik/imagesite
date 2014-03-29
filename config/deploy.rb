require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '2.1.1'        # Or whatever env you want it to run in.
set :rvm_type, :user

# Bundler support
require 'bundler/capistrano'

# Stages
require 'capistrano/ext/multistage'
set :stages, %w(production)
set :default_stage, 'production'

set :application, "imagesite"
set :scm, :git
set :repository,  "git@github.com:ohenrik/imagesite.git" #"https://github.com/ohenrik/imagesite.git"


set :deploy_to, "/home/rails/apps/#{application}"
set :deploy_via, :remote_cache
set :copy_exclude, [ '.git' ]

set :user, "rails"

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 10
after "deploy:restart", "deploy:cleanup"
after :deploy, 'deploy:link_dependencies'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc <<-DESC
    Creates symbolic links to configuration files and other dependencies
    after deployment.
  DESC
  task :link_dependencies, :roles => :app do
    run "ln -nfs #{shared_path}/public/assets/themes/ #{current_path}/public/assets/themes"
    run "ln -nfs #{shared_path}/public/uploads/themes/ #{current_path}/public/uploads/themes"
    run "ln -nfs #{shared_path}/public/uploads/photo/ #{current_path}/public/uploads/photo"
    run "ln -nfs #{shared_path}/themes/ #{current_path}/themes"
    run "ln -nfs #{shared_path}/config/aws_environment_variables.rb #{current_path}/config/aws_environment_variables.rb"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before 'bundle:install', 'deploy:symlink_shared'

    		
    		



