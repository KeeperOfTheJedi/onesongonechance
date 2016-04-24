class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  def self.last_five(id)
  	conversation = Conversation.find(id)  	
    conversation.messages.order('created_at DESC').limit(5).reverse
  end
  def self.handling_emotion(text)
  		result = text;
		 result= result.gsub('<3', '<i class="fa fa-heart text-danger" aria-hidden="true"></i>')
		result = result.gsub('(y)', '<i class="fa fa-thumbs-up text-info" aria-hidden="true"></i>')
		result = result.gsub(':)', '<i class="fa fa-smile-o text-success" aria-hidden="true"></i>')
		result = result.gsub(':(', '<i class="fa fa-frown-o text-success" aria-hidden="true"></i>')
		
		return result
	end

end
