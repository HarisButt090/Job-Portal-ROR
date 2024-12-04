class Recruiter < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :company

  has_many :jobs, dependent: :destroy

  # Validations
  validates :user_id, :company_id, presence: true
end