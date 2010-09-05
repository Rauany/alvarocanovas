class Admin::PublicationsController < Admin::ApplicationController

  def index
    @publications = Publication.all
  end

  def create
    @publication = Publication.new(params[:publication])
    if @publication.save
      @publications = Publication.all
      flash.now[:notice] = "Photographie enregistrée avec succés"
      respond_to_parent { render :action => 'create.js.erb' }
    else
      flash.now[:notice] = "Echec de l'enregistrement"
      respond_to_parent { render :action => 'new.js.erb' }
    end
  end

  def edit
    @publication = Publication.find(params[:id])
  end

  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(params[:publication])
      flash.now[:notice] = "Photographie mise à jour avec succés"
      respond_to_parent { render :action => 'update.js.erb' }
    else
      flash.now[:notice] = "Echec de la mise à jour de la photographie"
      render :action => :edit
    end
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def new
    @publication = Publication.new
  end

  def destroy
    @publication = Publication.find(params[:id])
    if @publication.destroy
      flash.now[:notice] = "La photographie a été supprimée avec succés"
    else
      flash.now[:alert] = "Echec de la suppression du document"
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
