class FriendsController < ApplicationController
  before_filter :require_login

  def follow
    follow_to = params[:id].present? ? params[:id].gsub(/\D/, '').to_i : 0
    case true
    when follow_to == 0, !User.where("id = ?", follow_to).present?
      flash[:error] = "Invalid user ID"
    when follow_to == session[:user_id]
      flash[:error] = "Please don't hello yourself"
    when Friend.where(["follower_id = ? and following_id = ?", session[:user_id], follow_to]).present?
      flash[:info] = "Hello again!"
    else
      Friend.create({follower_id: session[:user_id], following_id: follow_to})
      flash[:success] = "Nice to meet you!"
    end
    redirect_to action: "people"
  end

  def unfollow
    unfollow = params[:id].present? ? params[:id].gsub(/\D/, '').to_i : 0
    case true
    when unfollow == 0, !User.where("id = ?", unfollow).present?
      flash[:error] = "Invalid user ID"
    when unfollow == session[:user_id]
      flash[:error] = "Please don't hello yourself"
    when Friend.where(["follower_id = ? and following_id = ?", session[:user_id], unfollow]).present?
      Friend.where(["follower_id = ? and following_id = ?", session[:user_id], unfollow]).last.destroy
      flash[:success] = "Bye Bye!"
    else
      flash[:error] = "No hello, No bye bye!"
    end
    redirect_to action: "people"
  end

  def people
    @following    = User.find_by(id: session[:user_id]).followings
    @not_following = User.find_by(id: session[:user_id]).not_followings
  end

  private

  def require_login
    unless session[:user_id].present?
       redirect_to root_path 
    end
  end

end
