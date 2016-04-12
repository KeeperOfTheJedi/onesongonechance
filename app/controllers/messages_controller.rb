class MessagesController < ApplicationController


  def index
    respond_to do |format|
      format.html { render layout: false }
      format.js
    end
  end
	def create
    @message = current_user.sent_messages.build message_params
    if @message.save
      respond_to do |format|
        format.js
        format.html {
          redirect_to root_path
        }
      end
    else
      respond_to do |format|
        format.js
        format.html {
          redirect_to root_path
        }
      end
    end
  end

  def destroy
    @message = Message.find params[:id]
    @message.destroy!
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
