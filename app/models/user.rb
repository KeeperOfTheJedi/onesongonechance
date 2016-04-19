class User < ActiveRecord::Base
  has_many :songs
  has_many :sent_messages, :foreign_key =>  'sender_id', class_name: 'Message'
  def to_s
    name
  end
  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.name     = auth.info.name
    user.email     = auth.info.email
    user.image     = auth.info.image
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    # if user.new_record?
      graph = Koala::Facebook::API.new(auth.credentials.token)
      profile = graph.get_object("me?fields=id,location,gender,languages,relationship_status,bio,cover")
      raise "Something wrong with facebook profile information" unless auth.uid == profile['id']
      user.gender = profile['gender'] if profile['gender'].present?
      user.location = profile['location']['name'] if profile['location'].present?
      user.languages = profile['languages'].map{|l| l['name']}.join(', ') if profile['languages'].present?
      user.bio = profile['bio'] if profile['bio'].present?
      user.cover = profile['cover']['source'] if profile['cover'].present?
    # end
    user.save
    return user
  end
end
