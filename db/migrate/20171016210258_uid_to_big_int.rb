class UidToBigInt < ActiveRecord::Migration[5.0]
  def change
    change_column(:users, :uid, :bigint, null: false)
  end
end
