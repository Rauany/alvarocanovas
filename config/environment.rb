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


#Vimeo :
#
#Consumer Key: 0cd46f431a7919e7a6539e469a77dfb1
#Consumer Secret: 9945b7731ebce6cc Please do not share this with others
#Callback URL: http://alvaro.webflows.fr/admin/videos
#Upload Access: Requested - pending
#
#Description:
#Profesional website of Alvaro Canovas, photographer
#
#Purpose: (not shown to users)
#Photographic and video galleries