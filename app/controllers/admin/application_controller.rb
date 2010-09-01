class Admin::ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable
  
  layout Proc.new{ |controller| controller.request.xhr? ? false : controller.layout_by_resource }

  before_filter :authenticate_user!

  protect_from_forgery

  def layout_by_resource
    if devise_controller?
      "layout_name_for_devise"
    else
      "admin"
    end
  end



end
