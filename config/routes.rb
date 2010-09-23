ActionController::Routing::Routes.draw do |map|
  map.resources :resumes


  map.root :controller => "welcome",       :action => "index"

  # --------- Sign Up
  map.signup    "/signup.html",   :controller => "users",         :action => "new"
  map.login     "/login.html",    :controller => "user_sessions", :action => "new"
  map.logout    "/logout.html",   :controller => "user_sessions", :action => "destroy"

  # Activate
  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id',              :controller => 'activations', :action => 'create'

  # Reset password
  map.resources :password_resets
  map.resources :user_sessions, :only => [:new, :create, :destroy]
  # ---------end Sign Up

  map.resources :users
  map.resource :account, :controller => "users", :only => [:show, :edit, :update]

  map.admin     "/admin",     :controller => "admin/users",         :action => "index"
  map.admin     "/dashboard", :controller => "dashboard/accounts",   :action => "show"

  map.get_passwords "/get_passwords.js", :controller => "welcome", :action => "get_passwords", :format => :js

  # Admin
  map.namespace :admin do |admin|
    admin.resources :users
  end

  # User
  map.namespace :dashboard do |dashboard|
    dashboard.resource :account, :controller => "accounts", :only => [:show, :edit, :update], :as => "account"
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

