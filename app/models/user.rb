class User < ActiveRecord::Base
  has_many :songs
  has_many :sent_messages, :foreign_key =>  'sender_id', class_name: 'Message'
  def to_s
    name
  end
  def self.from_omniauth(auth)
    # @graph = Koala::Facebook::API.new(auth.credentials.token)
    # profile = @graph.get_object("me")
    # friends = @graph.get_connections("me", "friends")
    # raise friends
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email     = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end
end
