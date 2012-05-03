# -*- encoding : utf-8 -*-
class Admin::CategoriesController < Admin::ApplicationController

  def index
    @categories = Category.where(:type => params[:type].blank? ? nil : params[:type]).includes(:pictures)
    render :action => :index
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash.now[:notice] = "Reportage mis a jour avec succès"
      respond_to_parent { render :action => 'update.js.erb' }
    else
      flash.now[:notice] = "Echec de la mise a jour du reportage"
      respond_to_parent { render :action => 'edit.js.erb' }
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash.now[:notice] = "Reportage supprimé avec succés"
    else
      flash.now[:notice] = "Impossible de supprimer le reportage"
    end
    render :text => nil
  end

  def new
    @category = params[:type].blank? ? Category.new : Client.new
  end

  def create
    @category = params[:type] == "Client" ? Client.new(params[:category]) : Category.new(params[:category])
    if @category.save
      @categories = @category.class.where(:type => params[:type].blank? ? nil : params[:type]).includes(:pictures)
      flash.now[:notice] = "Reportage créé avec succés"
      respond_to_parent { render :action => 'create.js.erb' }
    else
      flash.now[:notice] = "Echec de la création du reportage"
      respond_to_parent { render :action => 'new.js.erb' }
    end
  end

  def show
    @category = Category.find(params[:id])
    render :action => :update
  end
  

  def reorder
    @category = Category.find(params[:id])
    @category.update_attribute(:number, params[:position])
    @categories = Category.find_all_by_id(params[:ids])
    render :json => @categories.map(&:number)
  end

end
