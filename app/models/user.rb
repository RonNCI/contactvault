class User < ApplicationRecord
  # enables secure password functionality through bcrypt
  has_secure_password
  
  # strong validations for Contactvault users
  validates :email, presence: true, 
                   uniqueness: { case_sensitive: false }, # Ensures email is unique regardless of case
                   format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true, 
                      length: { minimum: 8, message: "must be at least 8 characters long" }, 
                      format: { with: /\A(?=.*[A-Z])(?=.*[a-z])(?=.*\d)/, # Regex for password complexity
                               message: "must include at least one uppercase letter, one lowercase letter, and one number" }

  # callback to normalize email before saving to database
  before_save :normalize_email

  private

  # converts email to lowercase and removes leading/trailing whitespace
  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end