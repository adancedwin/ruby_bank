require 'rails_helper'

RSpec.describe Transactions::TransferService, type: :service do
  let(:current_user) { create(:user) }
  let(:sender_account) { create(:account, user: current_user, balance: 100.0) }
  let(:receiver_account) { create(:account) }

  let(:valid_params) do
    {
      sender_account_number: sender_account.number,
      receiver_account_number: receiver_account.number,
      amount: '50.00'
    }
  end

  let(:invalid_params) do
    {
      sender_account_number: sender_account.number,
      receiver_account_number: 'invalid_account_number',
      amount: '60.00'
    }
  end

  subject { described_class.new(current_user, valid_params) }

  describe '#call' do
    context 'with valid parameters' do
      it 'transfers funds from sender to receiver account' do
        expect { subject.call }.to change { sender_account.reload.balance }.from(100.0).to(50.0)
                                                                           .and change { receiver_account.reload.balance }.from(0.0).to(50.0)
      end
    end

    context 'with invalid parameters' do
      subject { described_class.new(current_user, invalid_params) }

      it 'does not transfer funds and returns an error result_object' do
        expect { subject.call }.not_to change { sender_account.reload.balance }
        expect { subject.call }.not_to change { receiver_account.reload.balance }

        result_object = subject.call
        expect(result_object.success?).to be false
        expect(result_object.message).to eq('Invalid account number - invalid_account_number. Please check again.')
        expect(result_object.stage).to eq(:account)
      end
    end
  end
end
