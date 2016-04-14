class Conversation < ActiveRecord::Base
  belongs_to :init_user_song, :foreign_key => :init_user_song_id, class_name: 'Song'
  belongs_to :partner_user_song, :foreign_key => :partner_user_song_id, class_name: 'Song'
  has_many :messages, dependent: :destroy
  def self.check_user_in_conversation(current_user_id, conversation_id)
  	conversation = Conversation.find(conversation_id)
  	if conversation != nil
  		init_user_id = conversation.init_user_song.user_id
  		partner_user_id = conversation.partner_user_song.user_id
  		if partner_user_id == current_user_id || init_user_id == current_user_id
  			return true
  		else
  			return false
  		end
  	else
  		return false
  	end
  end
end
