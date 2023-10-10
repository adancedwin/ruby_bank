class CreateAccounts < ActiveRecord::Migration[7.0]
  def up
    create_table :accounts, id: :uuid do |t|
      t.string :number, null: false, index: { unique: true }
      t.decimal :balance, precision: 8, scale: 2, default: 0
      t.uuid :user_id, null: false, index: true

      t.timestamps
    end

    add_index :accounts, :number, unique: true
    add_index :accounts, [:user_id, :number], unique: true
  end

  def down
    drop_table :accounts

    remove_index :accounts, :number
    remove_index :accounts, [:user_id, :number]
  end
end
