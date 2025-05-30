# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.6'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.5', '>= 7.1.5.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

#
#  Custom Gems
#

# Disconnects all connections to PostgreSQL db when running rails db:reset
gem 'pgreset', group: %i[development test]

# Preset CSS styles
gem 'bootstrap', '~> 5.2.3'

# Cohesive themes using Bootstrap styles
gem 'bootswatch', github: 'thomaspark/bootswatch', tag: 'v5.2.3'

# Bootstrap-styled rails form helpers
gem 'bootstrap_form', '~> 5.2.3'

# User Authentication framework
gem 'devise'

# Testing framework
gem 'rspec-rails', '~> 6.1.3', group: %i[development test]

# Fixtures replacement
gem 'factory_bot_rails', group: %i[development test]

# Autorun tests in development with 'bundle exec guard init rspec' && 'bundle exec guard'
gem 'guard-rspec', require: false, group: %i[development test]

# Adds controller testing assertions
gem 'rails-controller-testing', group: %i[development test]

# Ruby static code analyzer (a.k.a. linter) and code formatter
# gem 'rubocop', require: false, group: %i[development test]

# Rubocop extensions
gem 'rubocop-capybara', require: false, group: %i[development test]
gem 'rubocop-factory_bot', require: false, group: %i[development test]
gem 'rubocop-rails', require: false, group: %i[development test]
gem 'rubocop-rspec', require: false, group: %i[development test]
gem 'rubocop-rspec_rails', require: false, group: %i[development test]

# Lint your ERB or HTML files
gem 'erb_lint', require: false, group: %i[development test]
gem 'htmlbeautifier', require: false, group: %i[development test]
