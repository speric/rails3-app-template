class UsersController < ApplicationController
  before_filter :require_admin, :only => :index
  before_filter :require_user, :except => [:new, :create]
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_url, :notice => 'Registration successfull.'
    else
      render :action => "new"
    end
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => 'Your profile has been updated'
    else
      render :action => :edit
    end
  end  
end