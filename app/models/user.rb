class User < ApplicationRecord
  # secures password with bcrypt
  has_secure_password
  # user has many contacts that will be destroyed if user is deleted
  has_many :contacts, dependent: :destroy
  
  # validates email presence and uniqueness
  validates :email, presence: true, uniqueness: true
  # validates password presence and minimum length of 6 characters
  validates :password, presence: true, length: { minimum: 6 }
end