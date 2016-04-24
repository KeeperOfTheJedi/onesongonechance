class UsersController < ApplicationController
  def my_profile
    @sections = ["picture", "globe", "music", "friends"]
    unless params[:section].present?
      @section = "globe"
    else
      @section = params[:section]
      raise "Section must be one of #{@sections.join(", ")}" \
        unless @sections.select{ |section| section == @section}.count == 1
    end
  end

  private
end
