class Contact < ApplicationRecord
  # defines the relationship with user
  belongs_to :user
  
  # validates required fields and formats
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone, format: { with: /\A[\d\-+\s\(\)]+\z/ }, allow_blank: true

  # callbacks for activity logging
  after_create :log_activity
  after_update :log_activity
  
  private
  
  # logs activity when contact is created or updated
  def log_activity
    action = self.created_at == self.updated_at ? 'added' : 'updated'
    Activity.create(
      user: self.user,
      action: action,
      subject: self.name,
      created_at: Time.current
    )
  end
end