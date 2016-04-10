class WelcomeController < ApplicationController

  def index
    if params[:search]
      @songs = Song.where(
       "lower(url) LIKE lower(?)",
       "%#{Regexp.escape(params[:search])}%")
      render 'index'
    else
      @songs = Song.order('created_at DESC')
      render 'index'
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(params.require(:video).permit(:url))
    if @song.save
      flash[:success] = 'Song added!'
      redirect_to root_url
    else
      render 'new'
    end
  end

end
