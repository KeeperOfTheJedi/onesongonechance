class DropSongsTable < ActiveRecord::Migration
  def change  
  	#remove_foreign_key :conversations, column: :song_id	
  	drop_table :songs
  end
end
