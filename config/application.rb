require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module LemonadeApi
  class Application < Rails::Application
    config.api_only = true
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV['RAILS_CORS_ORIGINS'] || 'localhost:4200'
        resource '*',
          headers: :any,
          methods: [:get, :post, :options, :delete, :put],
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client']
      end
    end
  end
end
