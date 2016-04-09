class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversation, index: true, foreign_key: true
      t.integer :sender_id
      t.string :content

      t.timestamps null: false
    end
  end
end
