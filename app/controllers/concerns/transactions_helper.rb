# frozen_string_literal: true

module TransactionsHelper
  extend ActiveSupport::Concern

  def user_transactions
    Transaction.where('sender_account_id IN (?) OR receiver_account_id IN (?)', accounts_ids, accounts_ids)
  end

  protected

  def accounts_ids
    current_user.accounts.pluck(:id)
  end
end
