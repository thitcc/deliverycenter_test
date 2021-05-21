# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'paper_trail'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'savon'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'redis'
gem 'jaro_winkler'
gem 'aws-sdk-sqs'
gem 'rest-client'

group :test do
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
  gem 'rainbow'
end

group :development, :test do
  gem 'pry', '~> 0.12.2'
  gem 'rubocop-rails'
  gem 'paranoia'
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
