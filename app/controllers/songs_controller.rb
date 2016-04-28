class SongsController < ApplicationController

	def pingsong_conversation
		
		msg = { :status => "ok", :message => "Success!", :html => ""  }
		timeout_second = 12
		current_time = Time.now.utc
		conversation = Conversation.find(params[:id])
		init_user_song = conversation.init_user_song
		partner_user_song = conversation.partner_user_song

		if(init_user_song.user_id == current_user.id)
			
			init_user_song.heart_beat = current_time
			init_user_song.save
			
			if(partner_user_song.status == "4")	  
				msg = { :status => "ok", :message => "Success!", :html => partner_user_song.user.name }

			elsif ((Time.now.utc - partner_user_song.heart_beat) > timeout_second && partner_user_song.status == "3")

				msg = { :status => "ok", :message => "Success!", :html => partner_user_song.user.name }

			elsif (partner_user_song.status == "3")
				msg = { :status => "ok", :message => "Success!", :html => "<strong>" + partner_user_song.user.name  + "</strong> join conversation" }
			end
			if conversation.status == 4
				msg = { :status => "ok", :message => "Success!", :html => partner_user_song.user.name }

			end


		elsif(partner_user_song.user_id == current_user.id)	
			partner_user_song.heart_beat = current_time
			partner_user_song.save

			if(init_user_song.status == "4")	  
				msg = { :status => "ok", :message => "Success!", :html => init_user_song.user.name }
			elsif ((Time.now.utc - init_user_song.heart_beat) > timeout_second && init_user_song.status == "3")
				msg = { :status => "ok", :message => "Success!", :html => init_user_song.user.name }
			elsif (init_user_song.status == "3")
				msg = { :status => "ok", :message => "Success!", :html => "<strong>" + init_user_song.user.name  + "</strong> join conversation" }

			end
			if conversation.status == 4
				msg = { :status => "ok", :message => "Success!", :html => init_user_song.user.name }

			end
			
		end
		respond_to do |format|   					
			format.json  { render :json => msg } 
		end	
	end
	def pingsong
		current_time = Time.now.utc
		song = Song.find(params[:id])
		song.heart_beat = current_time
		song.save
		result = { :status => "ok", :message => "Success!", :html => ""  }
		if song.status == "1"	#listenning song, not in conversation
			@new_conversation = Conversation.matching_new_conversation(song)

			if @new_conversation.id != nil
				result = { :status => "ok", :message => "Success!", :html => @new_conversation.id  }	    	  
			end		 
		elsif song.status == "2" #waiting join conversation
			@conversation = Conversation.find_conversation_by_song(song)
			if @conversation != nil
				result = { :status => "ok", :message => "Success!", :html => @conversation.id  }
			else
				Song.update_status(song, "1")
			end
		end
		respond_to do |format|   					
			format.json  { render :json => result } 
		end	
	end
	def addsong
		conversation = Conversation.find(params[:conversationid])

		@song = Song.new
		@song.utubeid=params[:id]
		@song.conversation_id = params[:conversationid].strip
		@song.name = params[:title]
		@song.length = YoutubeSearch.get_video_info_by_url(@song.utubeid)
		@song.status = "3"
		
		@song.heart_beat = Time.now.utc + @song.length;

		@song_partner = Song.new
		@song_partner.utubeid=params[:id]
		@song_partner.conversation_id = params[:conversationid]
		@song_partner.name = params[:title]
		@song_partner.length = @song.length
		@song_partner.status = "2";
		@song_partner.heart_beat = Time.now.utc + @song_partner.length;
		
		conversation.exp_time = conversation.exp_time + @song.length
		conversation.save

		partner_user_song_id = conversation.partner_user_song.user_id
		init_user_song_id = conversation.init_user_song.user_id
		
		if current_user.id == partner_user_song_id
			@song.user_id = partner_user_song_id
			@song_partner.user_id = init_user_song_id
			

		else
			@song.user_id = init_user_song_id
			@song_partner.user_id = partner_user_song_id
		end
		
		if @song.save && @song_partner.save
			respond_to do |format|   					
				format.json  { render :json => { :status => "ok", :message => "Success!", :html => @song  }}
			end	
		end

	end
	def getnewsong
		
		@new_songs = Song.where("conversation_id = ? AND user_id = ? AND status = ?", params[:id].to_i, current_user.id, '2').order("id ASC") 
		if !!@new_songs
				@new_songs.each do |song|
				song.status = "3"
				song.save
			end
			respond_to do |format|   					
				format.json  { render :json => { :status => "ok", :message => "Success!", :html => @new_songs  }}
			end	
		end
	end 
	
	def exit
		@song = Song.find(params[:id])
		@song.heart_beat = Time.now.utc - 30
		@song.save
		redirect_to root_path
	end
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
		@song = Song.new(song_params)
		@song.heart_beat = Time.now.utc
		@song.status = "1"

		if @song.save
			redirect_to song_path(@song)
		else
			flash.now[:error] = "#{@song.errors.full_messages.to_sentence}"
			render action: 'new'
		end
	end

	def show		
		@song = Song.find_by_id(params[:id])
		@song.heart_beat = Time.now.utc
		YoutubeSearch.get_video_info_by_url(@song.utubeid)
		
		@song.length = YoutubeSearch.get_video_info_by_url(@song.utubeid)
		@song.save
		Song.update_all_song_expired()
		Conversation.update_all_expired_conversation()


		if @song != nil
			if @song.user_id != current_user.id
				@song = nil
			else
				if @song.status == "4"
					@song = nil
				end
			end
		end

	end

	private
	def song_params
      params.permit(:name, :user_id, :utubeid, :length)#, :video_id, :gender)# :title, :status, , :gender, :pref 
  end
  
end