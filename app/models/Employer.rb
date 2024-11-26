class Employer < ApplicationRecord
  self.table_name = "recruiters"

  # Associations
  belongs_to :user
  belongs_to :company

  has_many :jobs, dependent: :destroy, foreign_key: 'recruiter_id'

  # Validations
  validates :user_id, :company_id, presence: true
end
