class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
    respond_to do |format|
      format.html { }
      format.js { render :action => "new", :layout => false }
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = I18n.t("your_login")
      redirect_back_or_default(root_url)
    else
      render :action => :new, :location => "login"
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = I18n.t("your_logout")
    redirect_to root_url
  end
end

