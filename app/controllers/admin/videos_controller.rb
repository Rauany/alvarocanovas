class Admin::VideosController < Admin::ApplicationController

  before_filter :get_owner

  before_filter :except => :authorize do
    check_vimeo_access if Rails.env == "production"
  end


  def get_owner
    @owner = User.find_by_name('owner')
  end

  def check_vimeo_access
    unless @owner.vimeo_check_access
      render :action => :authorize, :layout => false
    end
  end
   
  def authorize
    if params[:oauth_token].blank? or params[:oauth_verifier].blank?
      session[:oauth_secret] = @owner.vimeo.get_request_token.secret
      redirect_to @owner.vimeo.authorize_url
    else
      if @owner.vimeo_set_access(params[:oauth_token], session[:oauth_secret], params[:oauth_verifier])
        redirect_to admin_videos_path
      else
        render :action => :authorize
      end
    end
  end

  def index
    @videos = @owner.videos
  end

  def show
    @video = @owner.videos.find(params[:id])
  end

  def new
    @video = @owner.videos.new
  end

  def create
    @video = @owner.videos.build(params[:video])
    if @video.save and @video.upload(@video.source.path)
      @videos = @owner.videos(true)
      respond_to_parent { render :action => 'create.js.erb' }
    else
      respond_to_parent { render :action => 'new.js.erb' }
    end
  end

  def edit
    @video = @owner.videos.find(params[:id])
  end


  def update
    @video = @owner.videos.find(params[:video])
    if @video.save
      respond_to_parent { render :action => 'update.js.erb' }
    else
      respond_to_parent { render :action => 'edit.js.erb' }
    end
  end

  def destroy
    @video = @owner.videos.find(params[:id])
    if @video.destroy
      @videos = @owner.videos
    end
    render :text => nil
  end

  def reorder
    @video = Video.find_by_id(params[:id])
    @video.update_attribute(:number, params[:position])
    @videos = Video.find_all_by_id(params[:ids])
    render :json => @videos.map(&:number)
  end

  
end
