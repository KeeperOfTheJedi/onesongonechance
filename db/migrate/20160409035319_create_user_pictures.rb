class CreateUserPictures < ActiveRecord::Migration
  def change
    create_table :user_pictures do |t|
      t.references :user, index: true, foreign_key: true
      t.string :picture_metas

      t.timestamps null: false
    end
  end
end
