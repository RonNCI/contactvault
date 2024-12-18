class User < ApplicationRecord
  # adds methods to set and authenticate against a BCrypt password
  has_secure_password
  # ensures email is present, unique, and follows standard email format
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # ensures password is present and at least 6 characters long
  validates :password, presence: true, length: { minimum: 6 }
end