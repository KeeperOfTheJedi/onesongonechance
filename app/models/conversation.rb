class Conversation < ActiveRecord::Base
  belongs_to :init_user_song, :foreign_key => :init_user_song_id, class_name: 'Song'
  belongs_to :partner_user_song, :foreign_key => :partner_user_song_id, class_name: 'Song'
  has_many :messages, dependent: :destroy
  has_many :songs, dependent: :destroy
  def self.check_user_in_conversation(current_user_id, conversation)
  	
  	if conversation != nil
  		init_user_id = conversation.init_user_song.user_id
  		partner_user_id = conversation.partner_user_song.user_id
  		if partner_user_id == current_user_id || init_user_id == current_user_id
        if conversation.exp_time > Time.now
          return true
        else
          return false
        end
      else
       return false
     end
   else
    return false
  end
end
def self.partner_id(current_user_id, conversation)
  if conversation != nil
    init_user_id = conversation.init_user_song.user_id
    partner_user_id = conversation.partner_user_song.user_id
    if partner_user_id != current_user_id
      return partner_user_id
    else
      return init_user_id
    end
  end
end
def self.matching_new_conversation(song)
  
  partner_songs = Song.where("utubeid = ? and id != ? and status = ? and heart_beat > ?", song.utubeid, song.id, '1', Time.now.utc-20)
  if !!partner_songs
    partner_songs.each do |partner_song|  #check exit conversation with this partner
      exsit_conversation = Conversation.where('init_user_song_id = ? AND partner_user_song_id = ?', song.id, partner_song.id)
      if exsit_conversation.count == 0
        exsit_conversation = Conversation.where('init_user_song_id = ? AND partner_user_song_id = ?', partner_song.id, song.id)
      end

      if exsit_conversation.count == 0
           

        conversation = Conversation.new 
        conversation.init_user_song_id = song.id
        conversation.partner_user_song_id = partner_song.id
        conversation.exp_time = Time.now + (song.length + 10)
        conversation.save
        Song.update_when_matching(partner_song, "2",conversation.id)
        Song.update_when_matching(song, "2",conversation.id)   
        
        break
      end

    end
    
  else
    return nil
  end
end
  def self.find_conversation_by_song(song)
     conversations = Conversation.where("init_user_song_id = ? or partner_user_song_id = ?", song.id, song.id);
     if conversations.count >0
      return conversations.first
    end
  end
  def self.update_all_expired_conversation
    conversations = Conversation.where("exp_time < ? and status = 1", Time.now)
    i = conversations.count
    while i !=0
      conversations[i].status = 4
      conversations[i].save
    end
    
  end
  def self.deactive_all_conversation_by_song(song)
    conversations= Conversation.where(conver)
  end
end
