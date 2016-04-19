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
end
