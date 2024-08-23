class User < ApplicationRecord
  has_secure_password  # パスワードのハッシュ化と認証機能を追加

  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true, length: { minimum: 6 }
end
