class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user =User.create users_params
    if @user.persisted?
      flash[:success] = "Registered successfully"
      redirect_to root_path
    else
      flash.now[:error] = "Error #{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  private

  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
