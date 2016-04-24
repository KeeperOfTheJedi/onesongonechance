class User < ActiveRecord::Base
  has_many :songs
  has_many :user_pictures
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
    if user.new_record?
      graph = Koala::Facebook::API.new(user.oauth_token)
      profile = graph.get_object("me?fields=id,location,gender,languages,relationship_status,bio,cover")
      raise "Something wrong with facebook profile information" unless auth.uid == profile['id']
      user.gender = profile['gender'] if profile['gender'].present?
      user.location = profile['location']['name'] if profile['location'].present?
      user.languages = profile['languages'].map{|l| l['name']}.join(', ') if profile['languages'].present?
      user.bio = profile['bio'] if profile['bio'].present?
      user.cover = profile['cover']['source'] if profile['cover'].present?
      user.save
      (1..6).each do |i| #the easiest way to keep the images order if we create the list at the begin
        photo = UserPicture.find_or_initialize_by(:user_id => user.id, :order => i)
        photo.picture_metas = nil
        photo.save
      end
    end
    user.save
    return user
  end
  def fb_albums
    graph = Koala::Facebook::API.new(self.oauth_token)
    albums = graph.get_object("#{self.uid}?fields=id,photos.limit(1){picture},albums.limit(100){name, photos.limit(1){name,picture}}")
    #raise albums
    # album_list = [albums['photos']['data'][0].merge({'name'=>'Photos of You'})]
    album_list = [{'name'=>'Photos of You', 'picture' => albums['photos']['data'][0]['picture'], 'id' => albums['id']}]
    albums['albums']['data'].map{|a| {'name' => a['name'], 'picture' => a['photos']['data'][0]['picture'], 'id' => a['id']}}.each do |album|
      album_list.push(album)
    end
    album_list
  end
  def fb_photos(album_id)
    graph = Koala::Facebook::API.new(self.oauth_token)
    photos = graph.get_object("#{album_id}?fields=id,photos.limit(1000){picture,name}")
    photos['photos']['data']
  end
  def fb_photo(photo_id)
    graph = Koala::Facebook::API.new(self.oauth_token)
    photo = graph.get_object("#{photo_id}?fields=id,images,album,picture,name")
  end
  def fb_music
    graph = Koala::Facebook::API.new(self.oauth_token)
    music = graph.get_object("#{self.uid}?fields=id,music")
    music['music']['data'] if music['music'].present?
  end
  def fb_friends
    graph = Koala::Facebook::API.new(self.oauth_token)
    friends = graph.get_object("#{self.uid}?fields=id,friends.limit(1000){name,picture}")
    friends['friends']['data'] if friends['friends'].present?
  end
end
