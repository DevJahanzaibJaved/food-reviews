class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  normalizes :email, with: ->(e) { e.strip.downcase }
  normalizes :phone, with: ->(p) { p.strip }

  enum :plan, { free: "free", paid: "paid" }
  enum :status, { pending: "pending", approved: "approved", suspended: "suspended" }

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :owner_name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :email, presence: true, 
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { minimum: 10, maximum: 20 }
  validates :address, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :plan, presence: true
  validates :status, presence: true

  # Scopes
  scope :approved, -> { where(status: "approved") }
  scope :pending, -> { where(status: "pending") }
  scope :suspended, -> { where(status: "suspended") }
  scope :active, -> { where(status: "approved") }

  # Helper methods
  def approved?
    status == "approved"
  end

  def pending?
    status == "pending"
  end

  def suspended?
    status == "suspended"
  end

  def active?
    approved? && !suspended?
  end
end
