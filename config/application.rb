require File.expand_path('../boot', __FILE__)

# require 'rails/all'
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Onesongonechance
  class Application < Rails::Application

     config.active_record.raise_in_transactional_callbacks = true
  end
end
require 'chat_backend'
    Rails.configuration.middleware.use ChatBackend
