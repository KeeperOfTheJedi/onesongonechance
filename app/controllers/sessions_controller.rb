class SessionsController < ApplicationController
  def create
    if @user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = @user.id
      flash[:success] = "Logged in"
      redirect_to root_path 
    else
      flash.now[:error] = "Log in failed"
      render 'new' 
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out"
    redirect_to root_path
  end
end
