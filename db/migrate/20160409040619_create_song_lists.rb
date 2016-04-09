class CreateSongLists < ActiveRecord::Migration
  def change
    create_table :song_lists do |t|
      t.references :song, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :type

      t.timestamps null: false
    end
  end
end
