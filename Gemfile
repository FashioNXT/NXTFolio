source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '3.2.2' #ruby '2.7.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.4.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5.6'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# Use Haml instead of ERB
gem 'haml'
#Carrier Wave for uploading images
gem 'carrierwave'
# See https://github.com/rails/execjs#readme for more supported runtimes

# # may be required with ruby 2.4
# gem 'therubyracer', platforms: :ruby
# # or
# gem 'mini_racer'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks

# Simple form gem
gem 'simple_form'
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
gem 'fog-aws'
gem 'aws-sdk-s3'

# gem 'fog'
gem 'figaro'
gem 'mini_magick'
gem 'redis'

#Now installing gems for paginating
gem 'will_paginate'
gem 'betterlorem'
gem 'bootstrap-sass'
gem 'bootstrap-will_paginate'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 6.0.0'

  gem 'capybara'
  gem 'selenium-webdriver', '~> 4.8.0'
  # to debug using cucumber binding.pry
  gem 'pry'
  
  gem 'simplecov'
  gem 'simplecov-rcov'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end
# to generate seed data for testing
gem 'faker'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "bcrypt"

gem "rails-controller-testing"
gem "factory_bot_rails"
#gem 'simplecov', :require => false, :group => :test
#gem 'simplecov-rcov'
# gem 'bootstrap'
# gem 'popperjs' 

# Fixes the problem of "You are using an old OmniAuth version"
# gem 'devise', github: 'heartcombo/devise', branch: 'main'
gem 'omniauth'
#works for omniauth 2.0
gem "omniauth-rails_csrf_protection"
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'city-state'
gem 'geocoder'

# Fixes the problem of "Your bundle is locked to mimemagic (0.3.5)""
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'

gem 'webdrivers', require: false

# avoid update to 3.0
gem 'rubyzip', "~> 2.3.0"


gem "ruby-openai"
