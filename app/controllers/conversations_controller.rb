class ConversationsController < ApplicationController
	def show
		@conversation_id = params[:id]
		@conversation = Conversation.find_by_id(@conversation_id)
		@check_user_in_conversation = Conversation.check_user_in_conversation(current_user.id, @conversation)
		if @check_user_in_conversation
			init_user_song = @conversation.init_user_song
			partner_user_song = @conversation.partner_user_song
			if(init_user_song.user_id == current_user.id)
				if init_user_song.status == "2"
					init_user_song.status = "3"
					init_user_song.heart_beat = Time.now.utc
					init_user_song.save
					
				end
			elsif(partner_user_song.user_id == current_user.id)	
				if partner_user_song.status == "2"
					partner_user_song.status = "3"
					partner_user_song.heart_beat = Time.now.utc
					partner_user_song.save
					
				end
			end
			@partnerid = Conversation.partner_id(current_user.id, @conversation)
			@partner = User.find(@partnerid)
			@song = @conversation.init_user_song
		end
	end
	def cancel
		
	end
	
end
