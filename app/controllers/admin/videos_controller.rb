class Admin::VideosController < Admin::ApplicationController

  before_filter :get_owner
  before_filter :check_vimeo_access, :except => :authorize

  def get_owner
    @owner = User::OWNER
  end

  def check_vimeo_access
    unless @owner.vimeo_check_access
      render :action => :authorize, :layout => false
    end
  end
   
  def authorize
    if params[:oauth_token].blank? or params[:oauth_verifier].blank?
      session[:oauth_secret] = @owner.vimeo.get_request_token.secret
      redirect_to @user.vimeo.authorize_url
    else
      if @user.vimeo_set_access(params[:oauth_token], session[:oauth_secret], params[:oauth_verifier])
        redirect_to videos_path
      else
        render :action => :authorize
      end
    end
  end

  def index
    @owner.videos
  end

  def show
    @owner.videos.find(params[:id])
  end
  
end
