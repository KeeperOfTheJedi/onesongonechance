class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :geoposition, :string
    add_column :users, :languages, :string
    add_column :users, :bio, :text
  end
end
