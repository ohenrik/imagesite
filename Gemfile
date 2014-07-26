source 'https://rubygems.org'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
gem 'pg'



# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# To fix issue related to on page ready event
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

#gem 'activerecord-session_store'

#My gems


# remember to install Image Magic for this gem to work! Or you will recieve "No such file or directory error"
gem 'mini_magick'

gem 'liquid'


gem 'rubyzip'

# Html editor
gem 'wysihtml5-rails'
gem 'font-awesome-sass'
gem 'sanitize-rails', :require => 'sanitize/rails'

# Tables with sort and search
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'

# Navigation and page_items
gem 'ancestry'
gem 'acts_as_list'

# Settings
# gem 'rails-settings-cached'

# Jquery upload (multiple file upload)
gem 'jquery-fileupload-rails'

#For s3 storage of images (using carriewave)
gem 'carrierwave'
#gem 'carrierwave_direct'
#gem 's3_direct_upload'
gem 'fog'
gem 'unf'

# Background processing (also needed for carrierwave direct)
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil


#gem "therubyracer"
#gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
#gem "twitter-bootstrap-rails"

# Bootstrap gems
gem 'bootstrap-sass', '~> 3.1.1'

# Old sass bootstrap
#gem 'bootstrap-sass-rails'
#gem 'jquery-ui-bootstrap-rails'

# jquery validation
gem 'jquery-validation-rails'

# caching
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'

# HTML email gem for inlining css
gem 'roadie'
#gem 'nokogiri'
#gem 'premailer-rails'

# Add Paymill for transactions
gem 'paymill'

## Test gems
gem "rspec-rails", :group => [:test, :development]
group :test do 
	gem 'factory_girl_rails'
	gem 'capybara'
	gem 'guard-rspec'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Use Capistrano for deployment
gem 'capistrano', '2.15.5', group: :development
gem 'rvm-capistrano', group: :development
gem 'capistrano-sidekiq' , group: :development

