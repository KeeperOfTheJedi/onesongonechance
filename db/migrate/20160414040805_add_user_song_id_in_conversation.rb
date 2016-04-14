class AddUserSongIdInConversation < ActiveRecord::Migration
  def change
  	
  	remove_column  :conversations, :song_id, :integer	
  	rename_column  :conversations, :init_user_id, :init_user_song_id	
  	rename_column  :conversations, :partner_user_id, :partner_user_song_id	
  end
end
