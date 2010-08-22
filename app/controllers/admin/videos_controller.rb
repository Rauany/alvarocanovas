class Admin::VideosController < Admin::ApplicationController

  def index
    @videos = Video.all
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      @videos = Video.all
      flash.now[:notice] = "Photographie enregistrée avec succés"
      respond_to_parent { render :action => 'create.js.erb' }
    else
      flash.now[:notice] = "Echec de l'enregistrement"
      respond_to_parent { render :action => 'new.js.erb' }
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      flash.now[:notice] = "Photographie mise à jour avec succés"
      respond_to_parent { render :action => 'update.js.erb' }
    else
      flash.now[:notice] = "Echec de la mise à jour de la photographie"
      render :action => :edit
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def destroy
    @video = Video.find(params[:id])
    if @video.destroy
      flash.now[:notice] = "La video a été supprimée avec succés"
    else
      flash.now[:alert] = "Echec de la suppression de la video"
    end
    render :text => nil
  end
  def reorder
    params[:ordered_ids].each_with_index do |picture_id, index|
      Picture.find(picture_id).update_attribute(:number, index + 1)
    end
    render :text => nil
  end

end
