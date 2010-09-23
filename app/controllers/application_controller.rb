# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # include ExceptionNotifiable

  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user_session, :current_user, :current_subdomain
  filter_parameter_logging :password, :password_confirmation
  before_filter :set_current_user, :set_current_city



  def permission_denied
    flash[:error] = I18n.t(:permission_denied)
    redirect_to root_path
  end

  def page_options(count_per_page = 20)
    @page = (params[:page] || 1).to_i
    @page = 1 if @page < 1
    @per_page = (RAILS_ENV=='test' ? 10 : count_per_page).to_i
    { :per_page => @per_page, :page => @page }
  end

  #def default_url_options(options)
    #{ :format => 'html' }
  #end

  private
  # получение субдомена из запроса
  def set_current_city
    @subdomain = self.request.subdomains.first rescue nil
    #@city = City.find_by_en(@subdomain) if @subdomain
    #@city = City.find_by_en("tomsk") #if @subdomain
  end

  def set_current_user
    Authorization.current_user = current_user
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
        flash[:notice] = I18n.t(:require_user)
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = I18n.t(:require_no_user)
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end

