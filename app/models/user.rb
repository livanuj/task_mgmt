class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :email, :password_digest, presence: true
  validate :valid_email_address

  private

  def valid_email_address
    return if email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    errors.add(:email, "is not a valid email address.")
  end
end
