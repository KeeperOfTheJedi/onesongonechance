class MessagesController < ApplicationController
  before_filter :require_login

  def index
  end

  def create
  end

  def show
  end

  private

  def require_login
    unless session[:user_id].present?
       redirect_to root_path 
    end
  end

end
