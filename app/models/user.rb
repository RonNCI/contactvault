class User < ApplicationRecord
  # handles password encryption and authentication
  has_secure_password
  # user can have multiple contacts that will be deleted when user is deleted
  has_many :contacts, dependent: :destroy
  # user can have multiple activities that will be deleted when user is deleted
  has_many :activities, dependent: :destroy

  # ensures email is present and unique across all users
  validates :email, presence: true, uniqueness: true
  # ensures password is present and at least 6 characters long
  validates :password, presence: true, length: { minimum: 6 }
end
