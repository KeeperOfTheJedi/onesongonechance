class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :reporter_user_id
      t.integer :blamed_user_id
      t.string :message

      t.timestamps null: false
    end
  end
end
