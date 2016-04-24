class AddOrderToUserPicture < ActiveRecord::Migration
  def change
    add_column :user_pictures, :order, :integer
  end
end
