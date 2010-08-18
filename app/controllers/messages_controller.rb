class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      MessageMailer.email_alvaro(@message).deliver
      @message = Message.new
    end
  end

end
