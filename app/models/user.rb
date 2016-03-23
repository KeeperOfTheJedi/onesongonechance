class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  validates :name, presence: true

  has_many :sent_message, class_name: "Message", foreign_key: "sender_id"
  has_many :sent_recieved, class_name: "Message", foreign_key: "recipient_id"

  has_many :following, class_name: "Friend", foreign_key: "follower_id"
  has_many :follower, class_name: "Friend", foreign_key: "following_id"

  has_many :followings, through: :following
  has_many :followers, through: :follower

  def to_s
    name
  end

  def not_followings 
    User.where.not({id: self.following.present? ? 
      self.following.map{|x| x = x[:following_id]}.push(self.id) : self.id
    })
  end

end
