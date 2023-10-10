# frozen_string_literal: true

module Transactions
  # This class is responsible for handling the transfer validation and creation
  class TransferService
    # @param [User] current_user
    # @param [Hash] params
    # @option params [String] :sender_account_number
    # @option params [String] :receiver_account_number
    # @option params [String] :amount
    def initialize(current_user, params)
      @params = params
      @current_user = current_user
      @sender_account_number = params[:sender_account_number]
      @receiver_account_number = params[:receiver_account_number]
      @amount = BigDecimal(params[:amount])
      @result_object = nil
    end

    # @return [Struct] result_object
    # @return [Boolean] result_object#success?
    # @return [String] result_object#message
    # @return [Symbol, nil] result_object#stage
    def call
      transfer!
      @result_object
    end

    private

    attr_reader :current_user,
                :sender_account_number,
                :receiver_account_number,
                :amount,
                :params

    def transfer!
      ActiveRecord::Base.transaction do
        sender_account = fetch_sender_account
        receiver_account = fetch_receiver_account

        # Lock sender and receiver accounts
        # PostgreSQL and MySQL support row-level locking, for other databases this may not work
        sender_account&.lock!
        receiver_account&.lock!

        @result_object = Transactions::ValidatorService.new(
          current_user,
          sender_account,
          receiver_account,
          params
        ).call

        raise ActiveRecord::Rollback unless @result_object.success?

        create_transaction!(sender_account, receiver_account, amount)
      end
    end

    def fetch_sender_account
      Account.find_by(number: sender_account_number)
    end

    def fetch_receiver_account
      Account.find_by(number: receiver_account_number)
    end

    def create_transaction!(sender_account, receiver_account, amount)
      bank_transaction = Transaction.new(sender_account_id: sender_account.id,
                                         receiver_account_id: receiver_account.id,
                                         amount:)
      return error_object(bank_transaction.errors.full_messages.join(', '), :transaction) unless bank_transaction.save!

      sender_account.update(balance: sender_account.balance - amount)
      receiver_account.update(balance: receiver_account.balance + amount)
    end
  end
end
