# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    render :action => :show
  end

  def index
    @pictures = Picture.where(:top => true).shuffle
  end
end
