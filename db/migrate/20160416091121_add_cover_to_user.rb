class AddCoverToUser < ActiveRecord::Migration
  def change
    add_column :users, :cover, :string
  end
end
