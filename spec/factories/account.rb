FactoryBot.define do
  factory :account do
    number { Faker::Number.number(digits: 5) }
    user
    balance { 0 }
  end
end
