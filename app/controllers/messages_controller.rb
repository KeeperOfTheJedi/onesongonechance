class MessagesController < ApplicationController
  before_filter :require_login

  def index
    @messages = Message.where("recipient_id = ?", current_user.id)
  end

  def new
    @contacts = current_user.followings.present? ? 
      current_user.followings.map{|x| [x[:name], x[:id]]} : nil
  end

  def create
    @message = Message.create message_params.merge({sender_id: current_user.id})
    if @message.persisted?
      flash[:success] = "Message sent to #{@message.recipient.name}"
      redirect_to messages_path
    else
      flash.now[:error] = "Error #{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def show
    @message = Message.find_by(id:params[:id], recipient_id:current_user.id)
    if @message.present?
      @message.read_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    end
  end

  private

  def require_login
    unless session[:user_id].present?
       redirect_to root_path 
    end
  end
  def message_params
    params.require(:message).permit(:title, :body, :recipient_id)
  end

end
