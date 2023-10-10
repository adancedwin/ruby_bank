class RenameFieldsInTransations < ActiveRecord::Migration[7.0]
  def up
    add_column :transactions, :sender_account_id, :uuid, null: false
    add_column :transactions, :receiver_account_id, :uuid, null: false

    Transaction.all.each do |transaction|
      transaction.update(sender_account_id: transaction.sender_id, receiver_account_id: transaction.receiver_id)
    end

    safety_assured { remove_column :transactions, :sender_id }
    safety_assured { remove_column :transactions, :receiver_id }
  end

  def down
    rename_column :transactions, :sender_account_id, :sender_id
    rename_column :transactions, :receiver_account_id, :receiver_id
  end
end
