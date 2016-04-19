class ConversationsController < ApplicationController
	def show
		@conversation_id = params[:id]
		@conversation = Conversation.find_by_id(@conversation_id)
		@check_user_in_conversation = Conversation.check_user_in_conversation(current_user.id, @conversation)
		if @check_user_in_conversation
			@partnerid = Conversation.partner_id(current_user.id, @conversation)
			@partner = User.find(@partnerid)
			@song = @conversation.init_user_song
		end
		
		  
		if query = params[:q]
			

      @results = YoutubeSearch.search query
    end
	end
	
end
