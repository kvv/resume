class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user,    :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new
    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = I18n.t('activate.users.create')
      redirect_to root_url
    else
      render :action => :new,  :location => signup_url
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url
    else
      render :action => "edit"
    end
  end

end

