class Admin::ApplicationController < ActionController::Base

  layout Proc.new{ |controller| controller.request.xhr? ? false : 'admin' }

  before_filter :authenticate_user!, :set_locale

  protect_from_forgery

  def set_locale
    I18n.locale = :en
  end


end
