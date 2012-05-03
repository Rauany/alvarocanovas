# -*- encoding : utf-8 -*-
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'fakeweb'

#system "cd #{Rails.root}\;RAILS_ENV=test script/delayed_job restart"

FakeWeb.allow_net_connect = false

class ActiveSupport::TestCase
  include Devise::TestHelpers
  RESPONSES_PATH = File.join(Rails.root,'test/fakeweb_responses')
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...


  def response_bodies(*file_names)
    file_names.flatten.collect do |file_name|
      {:body => File.join(RESPONSES_PATH, "#{file_name}.json")}
    end
  end

  def register_uri(method, uri, *file_names)
    FakeWeb.register_uri(method,uri, response_bodies(*file_names))
  end

end
