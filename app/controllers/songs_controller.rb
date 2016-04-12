class SongsController < ApplicationController

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
    # @song = Song.new(params.require(:song).permit(:url))
    @song = Song.new(song_params)
    if @song.save
      flash[:success] = 'Video added!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def song_params
    params.require(:song).permit(:url, :uid, :name)
  end

end
