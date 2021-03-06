# -*- encoding : utf-8 -*-
Alvarocanovas::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  
  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  config.action_view.javascript_expansions[:defaults] = [
    'jquery1.4.1',
    'rails',
    'jquery.livequery',
    'jquery.ga.debug'
  ].collect{|f| "lib/#{f}"}

  config.action_view.javascript_expansions[:galleria] = ['lib/galleria/galleria']
end
