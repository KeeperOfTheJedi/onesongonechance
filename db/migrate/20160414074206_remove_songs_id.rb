class RemoveSongsId < ActiveRecord::Migration
  def change
  	remove_index :conversations, :songs_id
  	remove_column :conversations, :songs_id, :integer
  end
end
