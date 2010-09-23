class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = I18n.t('recover_your_password.flash.create.ok')
      redirect_to root_url
    else
      flash[:notice] = I18n.t('recover_your_password.flash.create.error')
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = I18n.t('recover_your_password.flash.update.ok')
      redirect_to root_path
    else
      render :action => :edit
    end
  end

  private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id], 24.hours)
    unless @user
      flash[:notice] = I18n.t('recover_your_password.flash.error_url')
      redirect_to root_url
    end
  end
end

