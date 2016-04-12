class User < ActiveRecord::Base
  has_secure_password
  has_many :sent_messages, :foreign_key =>  'sender_id', class_name: 'Message'
  def to_s
    name
  end
end
