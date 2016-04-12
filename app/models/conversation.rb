class Conversation < ActiveRecord::Base
  belongs_to :Song
  has_many :messages, dependent: :destroy
end
