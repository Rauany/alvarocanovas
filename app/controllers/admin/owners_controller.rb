class Admin::OwnersController < Admin::ApplicationController

  before_filter :get_owner

  def get_owner
    @owner = User::OWNER
  end

  def edit

  end

  def update
    if @owner.update_attributes(params[:owner])
      render :action => :update
    else
      render :action => :edit
    end
  end

  def show

  end

end