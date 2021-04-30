source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.7.2'
# Use postgresql as the database for Active Record
gem 'pg', '0.21.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use Haml instead of ERB
gem 'haml'
#Carrier Wave for uploading images
gem 'carrierwave'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'fog-aws'
gem 'fog'
gem 'figaro'
gem 'mini_magick'
gem 'redis'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'

  gem 'rspec-rails', '~> 3.5'

  gem 'capybara', '~> 3.32', '>= 3.32.2'
  gem 'selenium-webdriver', '~> 3.142', '>= 3.142.7' 
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "bcrypt", '~> 3.1.7'

# group :test, :development do
#   gem 'cucumber-rails', :require => false
#   # database_cleaner is not required, but highly recommended
#   gem 'database_cleaner'
# end

# group :development, :test do
#   gem 'rspec-rails', '~> 3.5'
# end

gem "rails-controller-testing"
gem "factory_bot_rails", "~> 4.0"
gem 'simplecov', :require => false, :group => :test
gem 'simplecov-rcov'

# Fix the problem of "You are using an old OmniAuth version"
gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'
gem 'omniauth', '~>2.0'
gem "omniauth-rails_csrf_protection", '~> 1.0' #works for omniauth 2.0
#gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2', '~> 1.0.0'
gem 'city-state'
gem 'geocoder'
ruby '2.4.1' #ruby '2.4.1'

# Fix the problem of "Your bundle is locked to mimemagic (0.3.5)""
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'

gem 'webdrivers', '~> 4.0', require: false