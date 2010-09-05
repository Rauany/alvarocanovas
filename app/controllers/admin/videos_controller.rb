class Admin::VideosController < Admin::ApplicationController

  before_filter :get_owner
  before_filter :check_vimeo_access, :except => :authorize


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
    unless @video.save
      render :action => :new
    end
  end

  def update
    @video = @owner.videos.find(params[:video])
    unless @video.save
      render :action => :edit
    end
  end

  def destroy
    @video = @owner.videos.find(params[:id])
    if @video.destroy
      render :text => nil
    else
      render :text => nil
    end
  end

  def reorder
    params[:ordered_ids].each_with_index do |video_id, index|
      Video.find(video_id).update_attribute(:number, index + 1)
    end
    render :text => nil
  end

  
end
