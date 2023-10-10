# frozen_string_literal: true

module Transactions
  # This class is responsible for validating the bank transaction data before transfer happens
  class ValidatorService
    # @param [User] current_user
    # @param [Account] sender_account
    # @param [Account] receiver_account
    # @param [Hash] params
    # @option params [String] :sender_account_number
    # @option params [String] :receiver_account_number
    # @option params [String] :amount
    def initialize(current_user, sender_account, receiver_account, params)
      @current_user = current_user
      @sender_account = sender_account
      @receiver_account = receiver_account
      @sender_account_number = params[:sender_account_number]
      @receiver_account_number = params[:receiver_account_number]
      @amount = BigDecimal(params[:amount], 2)
      @result_object = success_object('Your transaction was successful.')
    end

    # @return [Struct] result_object
    # @return [Boolean] result_object#success?
    # @return [String] result_object#message
    # @return [Symbol, nil] result_object#stage
    def call
      check_accounts
      check_account_belongs_to_user
      check_funds

      @result_object
    end

    private

    attr_reader :current_user,
                :sender_account,
                :receiver_account,
                :sender_account_number,
                :receiver_account_number,
                :amount,
                :params

    def check_accounts
      return unless @result_object.success?

      if sender_account.nil? || receiver_account.nil?
        not_existing_account_number = sender_account.nil? ? sender_account_number : receiver_account_number
        return error_object("Invalid account number - #{not_existing_account_number}. Please check again.", :account)
      end

      true
    end

    def check_account_belongs_to_user
      return unless @result_object.success?

      all_user_account_numbers = current_user.accounts.pluck(:number)
      return if all_user_account_numbers.include?(sender_account_number)

      error_object('You are not authorized to use this account.', :user)
    end

    def check_funds
      return unless @result_object.success?

      return error_object('You have insufficient balance to transfer.', :funds) if sender_account.balance < amount

      true
    end

    def success_object(message)
      @result_object = OpenStruct.new(success?: true, message:, stage: nil)
    end

    def error_object(message, stage)
      if message.blank?
        message = "Transaction failed at #{stage} stage."
        stage = nil
      end

      @result_object = OpenStruct.new(success?: false, message:, stage:)
    end
  end
end
