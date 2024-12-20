class User < ApplicationRecord
  # secures password with bcrypt
  has_secure_password
  # user has many contacts that will be destroyed if user is destroyed
  has_many :contacts, dependent: :destroy
  # user has many activities that will be destroyed if user is destroyed
  has_many :activities, dependent: :destroy

  # validates email presence and uniqueness
  validates :email, presence: { message: "Email cannot be blank" }, uniqueness: true
  # validates password presence and minimum length
  validates :password, presence: { message: "Password cannot be blank" }, length: { minimum: 6, message: "Password must be at least 6 characters long" }
end