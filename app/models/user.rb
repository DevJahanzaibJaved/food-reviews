class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Roles: admin, restaurant_owner
  enum :role, { admin: "admin", restaurant_owner: "restaurant_owner" }

  validates :email_address, presence: true, uniqueness: { case_sensitive: false },
                            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }
  validate :password_complexity, if: -> { new_record? || !password.nil? }
  validates :role, presence: true

  # Scopes
  scope :admins, -> { where(role: "admin") }
  scope :restaurant_owners, -> { where(role: "restaurant_owner") }

  # Helper methods
  def admin?
    role == "admin"
  end

  def restaurant_owner?
    role == "restaurant_owner"
  end

  # Password reset token methods (Rails 8 authentication)
  def password_reset_token
    signed_id(expires_in: 15.minutes, purpose: :password_reset)
  end

  def self.find_by_password_reset_token!(token)
    find_signed!(token, purpose: :password_reset)
  end

  private

  def password_complexity
    return if password.blank?
    return if password.length < 8 # Skip complexity checks if length validation already failed

    errors.add(:password, "must contain at least one number") unless password.match?(/\d/)
    errors.add(:password, "must contain at least one uppercase letter") unless password.match?(/[A-Z]/)
    errors.add(:password, "must contain at least one lowercase letter") unless password.match?(/[a-z]/)
    errors.add(:password, "must contain at least one special character (!@#$%^&*()_+-=[]{}|;:'\",.<>?/)") unless password.match?(/[^A-Za-z0-9]/)
  end
end
