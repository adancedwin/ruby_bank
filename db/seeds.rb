# frozen_string_literal: true

# Create users

user_ids = []
10.times do
  user_ids << User.create(name: Faker::Name.name, email: Faker::Internet.email,
                          password: "1234567890").id
end

# Create accounts
account_ids = []
user_ids.each do |user_id|
  account_ids << Account.create(number: Faker::Bank.account_number, balance: Faker::Number.decimal(l_digits: 2),
                                user_id:).id
end

# Create transactions
account_ids.each do |account_id|
  10.times do
    Transaction.create(sender_account_id: account_id,
                       receiver_account_id: account_ids.sample,
                       amount: Faker::Number.decimal(l_digits: 2))
  end
end
