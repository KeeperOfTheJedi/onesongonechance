class AddConversationidInidInSong < ActiveRecord::Migration
  def change
  	add_reference :songs, :conversation, index: true, foreign_key:true
  end
end
