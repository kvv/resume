class Admin::UsersController < Admin::ApplicationController
  filter_resource_access
  inherit_resources
  defaults :resource_class => User,:collection_name => 'users', :instance_name => 'user'
  respond_to :html
end

