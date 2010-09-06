class Admin::ApplicationController < ActionController::Base

  layout Proc.new{ |controller| controller.request.xhr? ? false : 'admin' }

  before_filter :authenticate_user!

  protect_from_forgery

  skip_after_filter :add_google_analytics_code


end
