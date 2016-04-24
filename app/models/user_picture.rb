class UserPicture < ActiveRecord::Base
  belongs_to :user
  serialize :picture_metas, JSON

  def empty
    !self.picture_metas?
  end

  def picture
    if self.picture_metas?
      self.picture_metas['picture']
    else
      nil 
    end
  end
end
