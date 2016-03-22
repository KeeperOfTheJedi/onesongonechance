class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps null: false
    end
  end
end
