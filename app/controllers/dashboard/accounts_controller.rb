class Dashboard::AccountsController < Dashboard::ApplicationController
  filter_access_to :all, :context => :dashboard_accounts
  inherit_resources
  defaults :singleton => true, :route_prefix => 'dashboard'

  protected
  def resource
    @current_user
  end

  def build_resource(attributes = {})
    @user = current_user
    @user.new(attributes)
  end

end
