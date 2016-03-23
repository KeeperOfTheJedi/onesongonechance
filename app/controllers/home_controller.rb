class HomeController < ApplicationController
  def index
    if session[:user_id].present?
       redirect_to messages_path 
    end
  end
end
