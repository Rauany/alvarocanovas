# Load the rails application
require File.expand_path('../application', __FILE__)

Dir.glob(File.join(File.expand_path(Rails.root), "lib", "paperclip_processors", "*.rb")).each do |processor|
  require processor
end

# Initialize the rails application
Alvarocanovas::Application.initialize!

require 'exception_notification'
Alvarocanovas::Application.config.middleware.use ExceptionNotification,
  :email_prefix => "[Alvaro] ",
  :sender_address => %{"Rails" <notifier@w3bflows.com>},
  :exception_recipients => %w{nicolas@w3bflows.com}




Haml::Template.options[:ugly] = false


