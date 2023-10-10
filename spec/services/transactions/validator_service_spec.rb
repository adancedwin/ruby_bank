require 'rails_helper'
require 'bigdecimal'

RSpec.describe Transactions::ValidatorService, type: :service do
  let(:current_user) { create(:user) }
  let(:sender_account) { create(:account, user: current_user) }
  let(:receiver_account) { create(:account) }

  let(:valid_params) do
    {
      sender_account_number: sender_account.number,
      receiver_account_number: receiver_account.number,
      amount: '100.00'
    }
  end

  subject { described_class.new(current_user, sender_account, receiver_account, valid_params) }

  describe '#call' do
    context 'with valid parameters' do
      it 'returns a success result_object' do
        sender_account.update(balance: BigDecimal('150.00'))
        result_object = subject.call
        expect(result_object.message).to eq('Your transaction was successful.')
        expect(result_object.success?).to be true
      end
    end

    context 'with invalid parameters' do
      let(:third_account) { create(:account) }
      subject { described_class.new(current_user, sender_account, receiver_account, valid_params) }

      it 'returns an error result_object when the sender account does not belong to the user' do
        valid_params[:sender_account_number] = third_account.number
        result_object = subject.call
        expect(result_object.success?).to be false
        expect(result_object.message).to eq('You are not authorized to use this account.')
        expect(result_object.stage).to eq(:user)
      end

      it 'returns an error result_object when the sender or receiver account is not found' do
        valid_params[:receiver_account_number] = 'invalid_account_number'
        sender_account.update(balance: BigDecimal('150.00'))
        result_object = described_class.new(current_user, nil, receiver_account, valid_params).call
        expect(result_object.message).to match(/Invalid account number - .+ Please check again./)
        expect(result_object.success?).to be false
        expect(result_object.stage).to eq(:account)
      end

      it 'returns an error result_object when the sender account has insufficient balance' do
        sender_account.update(balance: BigDecimal('50.00'))
        result_object = subject.call
        expect(result_object.success?).to be false
        expect(result_object.message).to eq('You have insufficient balance to transfer.')
        expect(result_object.stage).to eq(:funds)
      end
    end
  end
end
