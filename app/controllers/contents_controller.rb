# -*- encoding : utf-8 -*-
class ContentsController < ApplicationController

  def show
    @content = Content.find(params[:id])
  end

  def contact
    @contact = Content::CONTACT
    @links =   Content::LINKS
  end
end
