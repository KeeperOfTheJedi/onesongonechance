class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :song, index: true, foreign_key: true
      t.integer :init_user_id
      t.integer :partner_user_id
      t.datetime :exp_time

      t.timestamps null: false
    end
  end
end
