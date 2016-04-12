# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require_relative 'lib/chat_backend'
run Rails.application
