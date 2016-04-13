class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|

      t.string :query
      t.json :raw

      t.timestamps null: false
    end
  end
end
