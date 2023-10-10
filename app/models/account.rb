# frozen_string_literal: true

class Account < ApplicationRecord
  validates_presence_of :number
  validates_uniqueness_of :number
  validates_uniqueness_of :number, scope: :user_id
  validates_numericality_of :balance, greater_than_or_equal_to: 0

  belongs_to :user

  # We cannot use 'dependent: :destroy' here because other users still need to see their transactions
  has_many :transactions
end
