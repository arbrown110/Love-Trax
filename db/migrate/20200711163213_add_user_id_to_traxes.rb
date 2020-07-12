class AddUserIdToTraxes < ActiveRecord::Migration[5.2]
  def change
    add_column  :traxes, :user_id,  :integer
  end
end
