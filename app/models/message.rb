class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  def self.last_five(id)
  	conversation = Conversation.find(id)  	
    conversation.messages.order('created_at DESC').limit(5).reverse
  end
end
