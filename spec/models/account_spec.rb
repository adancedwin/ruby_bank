# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    account = build(:account, user:)
    expect(account).to be_valid
  end

  it 'is not valid without a number' do
    account = build(:account, user:, number: nil)
    expect(account).not_to be_valid
  end

  it 'is not valid with a duplicate number' do
    create(:account, user:, number: 'Account-1')
    expect { create(:account, user:, number: 'Account-1') }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
