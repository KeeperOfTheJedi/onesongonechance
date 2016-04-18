class SongsController < ApplicationController

  def new
    @song = Song.new
  end

  def create
  	@song = Song.new(song_params)
  	if @song.save
      redirect_to song_path(@song)
    else
      flash.now[:error] = "#{@song.errors.full_messages.to_sentence}"
      render action: 'new'
    end
  end

  def show
    @song = Song.find(params[:id])
  	if query = params[:q]
      @results = YoutubeSearch.search query
    end
  end

  private
   def song_params
      params.permit(:user_id)#, :video_id, :gender)# :title, :status, , :gender, :pref 
    end
  
end