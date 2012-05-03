# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      flash.now[:sent] = t("message.sent")
      MessageMailer.email_alvaro(@message).deliver
      @message = Message.new
    end
  end

end
