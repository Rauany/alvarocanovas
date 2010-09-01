class ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable
  
  protect_from_forgery

  layout :layout_by_resource

  before_filter :set_locale

  def set_locale # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale =  params[:locale] =  params[:locale] || :fr
  end 

#  def default_url_options(options={})
##    logger.debug "default_url_options is passed options: #{options.inspect}\n"
#    { :locale => I18n.locale }
#  end

  def layout_by_resource
    if devise_controller?
      "authentification"
    else
      "application"
    end
  end

end
