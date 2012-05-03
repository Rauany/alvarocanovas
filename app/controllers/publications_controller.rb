# -*- encoding : utf-8 -*-
class PublicationsController < ApplicationController

  def index
    @publications = Publication.all
    render :action => :index
  end
end
