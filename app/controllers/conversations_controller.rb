class ConversationsController < ApplicationController
	def show
		@conversation_id = params[:id]
	end
end
