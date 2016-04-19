class SongsController < ApplicationController

	def pingsong
		current_time = Time.now
		conversation = Conversation.find(params[:c])
		init_user_song = Song.find(conversation.init_user_song)
		partner_user_song = Song.find(conversation.partner_user_song)
		if(init_user_song.user_id == current_user.id)
			init_user_song.heart_beat = current_time
			init_user_song.save
			if((Time.now - partner_user_song.heart_beat) >15)
				respond_to do |format|       
					msg = { :status => "ok", :message => "Success!", :html => partner_user_song.user.name }
		    	  format.json  { render :json => msg } # don't do msg.to_json
		    	end
		    end

		elsif(partner_user_song.user_id == current_user.id)
			partner_user_song.heart_beat = current_time
			partner_user_song.save
			if((Time.now - init_user_song.heart_beat) >15)
				respond_to do |format|       
					msg = { :status => "ok", :message => "Success!", :html => partner_user_song.user.name }
		    	  format.json  { render :json => msg } # don't do msg.to_json
		    	end
		    end
		else
			
		end

	end
	
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
end
