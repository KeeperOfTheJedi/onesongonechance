class RenameTypeColumnInSongTable < ActiveRecord::Migration
  def change
  	rename_column :songs, :type, :status
  end
end
