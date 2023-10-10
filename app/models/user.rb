class User < ApplicationRecord
  # Ignore column not to cache anymore until its removal
  self.ignored_columns = ["balance"]

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :accounts, dependent: :destroy
end