class ChangePicureMetaOnUserPictures < ActiveRecord::Migration
  def change
    change_column :user_pictures, :picture_metas, :text
  end
end
