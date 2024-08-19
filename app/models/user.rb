class User < ApplicationRecord
  has_secure_password  # Automatically handles password hashing and validation

  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
