class AddHeartBeatColumn < ActiveRecord::Migration
  def change
  	remove_index :song_lists, :song_id
  	remove_index :conversations, :song_id
  	add_column :song_lists, :heart_beat, :datetime  
  	add_column :song_lists, :name, :string  
  	add_column :song_lists, :length, :integer  	
  	add_column :song_lists, :utubeid, :string
  	remove_column :song_lists, :song_id
  end
end
