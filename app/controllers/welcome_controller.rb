class WelcomeController < ApplicationController

  def index

  end

  def get_passwords
    render :passwords, :layout => false
  end
end

