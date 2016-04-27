class UsersController < ApplicationController
  before_action :set_user, :check_banning, only: [:show]
  def my_profile
    @user = current_user
    @sections = ["picture", "globe", "music", "friends"]
    unless params[:section].present?
      @section = "globe"
    else
      @section = params[:section]
      raise "Section must be one of #{@sections.join(", ")}" \
      unless @sections.select{ |section| section == @section}.count == 1
      end
    end

    def show

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def check_banning
      @user = current_user
      @user.account_active?
    end
  end
