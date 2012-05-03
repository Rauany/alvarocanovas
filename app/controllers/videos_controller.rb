# -*- encoding : utf-8 -*-
class VideosController < ApplicationController
  
  def index
    @videos = Video.where("vimeo_id is not null")
  end

  def show
    @video = Video.find(params[:id])
  end
end
