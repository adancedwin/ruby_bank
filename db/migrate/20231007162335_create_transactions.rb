class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.decimal :amount, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
