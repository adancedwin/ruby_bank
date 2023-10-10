# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'
gem 'bcrypt', '~> 3.1', '>= 3.1.19'
gem 'bootsnap', require: false
gem 'bullet', '~> 7.1', '>= 7.1.1'
gem 'importmap-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'rubocop', '~> 1.56', '>= 1.56.4'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'strong_migrations', '~> 1.6', '>= 1.6.3'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.2', '>= 3.2.1'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'database_cleaner', '~> 2.0', '>= 2.0.2'
end

group :development do
  gem 'web-console'
end
