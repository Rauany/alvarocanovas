# -*- encoding : utf-8 -*-
class PicturesController < ApplicationController

  before_filter :get_category, :except => :top_list 

  def get_category
    @category = Category.find(params[:category_id])
  end

  def index
   @pictures = @category.pictures
  end
    
end
