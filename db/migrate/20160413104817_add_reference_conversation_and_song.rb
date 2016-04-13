class AddReferenceConversationAndSong < ActiveRecord::Migration
  def change
  	add_reference  :conversations, :songs, index: true, foreign_key: true
  end
end
