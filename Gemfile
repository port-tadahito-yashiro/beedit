source 'https://rubygems.org'

## declare gems rules ############################
# # gemURL
# gem 'XXXXX'
##################################################

## default gems ####################################################
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.18'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

## all common gems ##################################################

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development



# https://rubygems.org/gems/slack-api
gem 'slack-api'

# https://rubygems.org/gems/slim
gem 'slim', :require => 'slim-rails'
gem 'slim-rails'

# less(CSS)対応
gem 'less-rails'

# https://rubygems.org/gems/fullcalendar-rails
gem 'fullcalendar-rails', '2.2.2.0'

# https://rubygems.org/gems/momentjs-rails
gem 'momentjs-rails', '2.8.3'

# https://rubygems.org/gems/bootstrap3-datetimepicker-rails
gem 'bootstrap3-datetimepicker-rails'

# https://rubygems.org/gems/jquery-turbolinks
gem 'jquery-turbolinks'

# https://rubygems.org/gems/twitter-bootstrap-rails
gem 'twitter-bootstrap-rails'

# https://rubygems.org/gems/font-awesome-rails
gem 'font-awesome-rails'

# https://rubygems.org/gems/kaminari
gem 'kaminari', '~> 0.16.3'

# https://rubygems.org/gems/unicorn
gem 'unicorn'

# デプロイ用
gem 'capistrano', '~> 3.2.1'
gem 'capistrano-rails', '~> 1.1',   require: false
gem 'capistrano-rbenv', '~> 2.0',   require: false
gem 'capistrano-bundler', '~> 1.1', require: false
gem 'capistrano3-unicorn' #unicornを使っている場合のみ

# https://rubygems.org/gems/rubocop
gem 'rubocop', require: false

# https://rubygems.org/gems/rspec-rails
gem 'rspec-rails'

# https://rubygems.org/gems/cancancan
gem 'cancancan', '~> 1.13', '>= 1.13.1'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

## test gems #############################################
group :test do
  # https://rubygems.org/gems/capybara
  gem 'capybara'

  # https://rubygems.org/gems/database_rewinder
  gem 'database_rewinder'

  # https://rubygems.org/gems/factory_girl_rails
  gem 'factory_girl_rails'

  # https://rubygems.org/gems/faker
  gem 'faker'

  # https://rubygems.org/gems/guard-rspec
  gem 'guard-rspec'

  # https://rubygems.org/gems/launchy
  gem 'launchy'

  # https://rubygems.org/gems/mock_redis
  gem 'mock_redis'

  # https://rubygems.org/gems/poltergeist
  # https://rubygems.org/gems/phantomjs
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'

  # https://rubygems.org/gems/rack_session_access
  gem 'rack_session_access'

  # https://rubygems.org/gems/selenium-webdriver
  gem 'selenium-webdriver'

  # https://rubygems.org/gems/vcr
  gem 'vcr'

  # https://rubygems.org/gems/webmock
  gem 'webmock'
end
