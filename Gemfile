source 'https://rubygems.org'
git_source( :github ) { | repo | "https://github.com/#{ repo }.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3.2'

# Vedoc app models
# gem 'vedoc-plugin', git: 'https://github.com/vedoc/vedoc-plugin.git'
gem 'vedoc-plugin', git: 'https://github.com/vedoc/vedoc-plugin.git'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# ActiveRecord connection adapter for PostGIS, based on postgresql and rgeo
gem 'activerecord-postgis-adapter'
# Use Puma as the app server
# gem 'puma', '~> 3.11'
gem 'puma', '~> 6.4', '>= 6.4.2'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'sassc'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
# gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootsnap', '~> 1.18.3', require: false


# The administration framework
gem 'activeadmin'
# gem 'activeadmin', '~> 0.6.6'
# gem 'activeadmin', '4.0.0.beta5'
gem 'devise'

# Solution for file uploads
gem 'carrierwave'

# UI interface for rails-settings-cached in active admin
# agem 'activeadmin_settings_cached', '>= 2.3.1'
gem 'activeadmin_settings_cached', '~> 2.3', '>= 2.3.1'

# Ruby bindings to Firebase Cloud Messaging
gem 'fcm'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Ruby static code analyzer and code formatter
  gem 'rubocop', require: false
  # Shim to load environment variables from .env into ENV in development
  gem 'dotenv-rails'
  # An alternative to the standard IRB shell for Ruby.
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
