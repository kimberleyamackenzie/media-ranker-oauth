class AddUserOwnerColumnToWork < ActiveRecord::Migration[5.0]
  def change
    add_column(:works, :user_id, :bigint)
  end
end
