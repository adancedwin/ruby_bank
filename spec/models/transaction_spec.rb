require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:sender_user) { create(:user) }
  let(:receiver_user) { create(:user) }

  it "is valid with valid attributes" do
    transaction = build(:transaction)
    expect(transaction).to be_valid
  end

  it "is not valid without a sender account" do
    transaction = build(:transaction, sender_account: nil)
    expect(transaction).not_to be_valid
  end

  it "is not valid without a receiver account" do
    transaction = build(:transaction, receiver_account: nil)
    expect(transaction).not_to be_valid
  end

  it "is not valid without an amount" do
    transaction = build(:transaction, amount: nil)
    expect(transaction).not_to be_valid
  end

  it "is not valid with a non-numeric amount" do
    transaction = build(:transaction, amount: "invalid")
    expect(transaction).not_to be_valid
  end

  it "belongs to a sender account" do
    transaction = create(:transaction)
    expect(transaction.sender_account).to be_an_instance_of(Account)
  end

  it "belongs to a receiver account" do
    transaction = create(:transaction)
    expect(transaction.receiver_account).to be_an_instance_of(Account)
  end

  it "has a sender name method" do
    transaction = create(:transaction, sender_account: create(:account, user: sender_user))
    expect(transaction.sender_name).to eq(sender_user.name)
  end

  it "has a receiver name method" do
    transaction = create(:transaction, receiver_account: create(:account, user: receiver_user))
    expect(transaction.receiver_name).to eq(receiver_user.name)
  end
end
