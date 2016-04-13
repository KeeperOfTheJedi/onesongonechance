class ConversationsController < ApplicationController
	def show
		@conversation_id = params[:id]
		if query = params[:q]
      @results = YoutubeSearch.search query
    end
	end
end
