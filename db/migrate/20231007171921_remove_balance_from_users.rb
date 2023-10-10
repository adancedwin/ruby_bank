class RemoveBalanceFromUsers < ActiveRecord::Migration[7.0]
  def up
    safety_assured { remove_column :users, :balance }
  end

  def down
    add_column :users, :balance, :decimal
  end
end
