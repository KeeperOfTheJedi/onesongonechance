class ConversationsController < ApplicationController
	def show
		@conversation_id = params[:id]
		@check_user_in_conversation = Conversation.check_user_in_conversation(current_user.id, @conversation_id)
		if query = params[:q]
			

      @results = YoutubeSearch.search query
    end
	end
end
