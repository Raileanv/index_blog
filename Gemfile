# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'rails', '~> 7.0.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'redis', '~> 4.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false
gem 'rack-cors'

gem 'activerecord-import'
gem 'active_storage_validations'
gem 'devise'
gem 'devise-api'
gem 'discard'
gem 'dry-monads'
gem 'kaminari'
gem 'paper_trail'
gem 'pg_search'
gem 'sidekiq'
gem 'sinatra', require: false # For Sidekiq web UI

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'ffaker'
  gem 'pastel'
  gem 'pry-rails'
  gem 'tty-progressbar' # Fancy console output
  gem 'rubocop-rails'
  gem 'rubocop-performance'
  gem 'rubocop-gitlab-security'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'letter_opener_web'
end
