class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.integer :sender_id
      t.integer :recipient_id
      t.datetime :read_at

      t.timestamps null: false
    end
  end
end
