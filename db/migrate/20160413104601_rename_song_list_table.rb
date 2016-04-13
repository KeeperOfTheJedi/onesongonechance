class RenameSongListTable < ActiveRecord::Migration
  def change
  	rename_table :song_lists, :songs
  end
end
