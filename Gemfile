source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'

# AMS
gem 'active_model_serializers', '~> 0.10.2'

# Use MySql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'

# Flexible authentication solution for Rails
gem 'devise', '~> 4.2.0'

# Use Puma as the app server
gem 'puma', '~> 3.0'
gem 'devise-i18n'
gem 'net-ldap'
gem 'omniauth'
gem 'unicorn'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'pry'
  gem 'irbtools', require: 'irbtools/binding'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'guard-rspec'
  gem 'zeus'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'rails-erd'
  gem 'rails-controller-testing'
end

group :test do
  gem 'launchy'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
