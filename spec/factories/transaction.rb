FactoryBot.define do
  factory :transaction do
    sender_account { create(:account) }
    receiver_account { create(:account) }
    amount { 100.0 }
  end
end
