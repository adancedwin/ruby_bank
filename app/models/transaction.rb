# frozen_string_literal: true

class Transaction < ApplicationRecord
  # Ignore columns not to cache anymore until their removal
  self.ignored_columns = %w[sender_id receiver_id]

  validates_presence_of :sender_account_id, :receiver_account_id, :amount
  validates_numericality_of :amount

  belongs_to :sender_account, class_name: 'Account', foreign_key: 'sender_account_id'
  belongs_to :receiver_account, class_name: 'Account', foreign_key: 'receiver_account_id'

  def sender_name
    sender_account.user.name
  end

  def receiver_name
    receiver_account.user.name
  end
end
