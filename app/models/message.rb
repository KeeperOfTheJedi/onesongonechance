class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  def read_it
    if read_at.present?
      false
    else
      self.read_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      self.save
    end
  end
end
