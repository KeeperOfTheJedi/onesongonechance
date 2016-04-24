class Song < ActiveRecord::Base

	belongs_to :user
	belongs_to :conversation
	def self.update_status(song, status)
		song.status = status
		song.save
	end
	def self.update_when_matching(song, status, conversationId)
		song.conversation_id = conversationId
		song.status = status
		song.save
	end
	def self.update_all_song_expired
		songs = Song.where('heart_beat < ? and status != ?', Time.now.utc - 15, '4')
		songs.each do |song|
			song.status = "4"
			song.save
		end
	end
end


	# belongs_to :category # not yet implemented

	# This is supposed to create a match record in the Match table if two song records have the same video_id 
	# def self.match(video_id)
	# 	Song.where("video_id = ?", video_id)
	# end


# 	Below are the suggested migrations for the songs table and category table

#	class CreateSongs < ActiveRecord::Migration
#   def change
#     create_table :songs do |t|
#       t.string :title
#       t.string :status
#       t.string :video_id
# 	    t.string :gender
# 	    t.string :pref
#       t.integer :user_id

#       t.timestamps null: false
#     end
#   end
# end

# class CreateCategories < ActiveRecord::Migration
#   def change
#     create_table :categories do |t|
# 	  t.string :category_name
#       t.timestamps null: false
#     end
#   end
# end