require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # выключает возможность принимать соединения с любых хостов
    config.action_cable.disable_request_forgery_protection = false

    # конфигурация генератора тестов контроллеров
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helpers_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       contriller_spec: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
