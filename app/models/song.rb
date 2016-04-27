class Song < ActiveRecord::Base
	scope :now_playing, -> { where(["heart_beat = ?", Date.today]) }

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