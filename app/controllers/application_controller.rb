class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  helper_method :current_user
  # layout :determine_layout

  def current_user
    return @current_user if @current_user 
    if session[:user_id]
      @current_user = User.find session[:user_id]
      unless Time.at(@current_user.oauth_expires_at) > Time.now
        session[:user_id] = nil
        flash[:success] = "Your session is expired"
        redirect_to root_path
      end
      @current_user
    end
  end

  private
    # def determine_layout
    #   current_user ? "private" : "public"
    # end
end