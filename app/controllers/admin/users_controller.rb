class Admin::UsersController < Admin::ApplicationController
  # GET /admin/users
  # GET /admin/users.xml
  def index
    @users = User.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.xml
  def show
    @user = User.find(params[:id])
  end

  # GET /admin/users/new
  # GET /admin/users/new.xml
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /admin/users
  # POST /admin/users.xml
  def create
    @user = User.new(params[:user])
    @users = User.all 
    if @user.save
      render :action => :index
    else
      render :action => :new
    end
  end

  # PUT /admin/users/1
  # PUT /admin/users/1.xml
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :action => :show
    else
      render :action => :edit
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.xml
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      @users = User.all
      render :action => index
    end
  end
end
