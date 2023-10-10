# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid with a duplicate email' do
    create(:user, email: 'test@example.com')
    duplicate_user = build(:user, email: 'test@example.com')
    expect(duplicate_user).not_to be_valid
  end

  it 'is not valid with an invalid email format' do
    user = build(:user, email: 'invalid-email')
    expect(user).not_to be_valid
  end

  it 'is not valid with a short password' do
    user = build(:user, password: 'short')
    expect(user).not_to be_valid
  end

  it 'has many accounts' do
    user = create(:user)
    account1 = create(:account, user:)
    account2 = create(:account, user:)
    expect(user.accounts).to include(account1, account2)
  end

  it 'destroys associated accounts when destroyed' do
    user = create(:user)
    create(:account, user:)
    expect { user.destroy }.to change { Account.count }.by(-1)
  end
end
