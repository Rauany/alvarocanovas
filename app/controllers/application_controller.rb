class ApplicationController < ActionController::Base

  protect_from_forgery

  layout :layout_by_resource

  before_filter :set_locale

  def set_locale # if params[:locale] is nil then I18n.default_locale will be used
    session[:locale] = params[:locale] ? params[:locale] : (session[:locale] || :fr)
    I18n.locale = session[:locale]
  end 

  def layout_by_resource
    if devise_controller?
      "authentification"
    else
      "application"
    end
  end

end
