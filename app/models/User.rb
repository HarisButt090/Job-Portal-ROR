class User < ApplicationRecord
  # devise configurations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # associations
  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy
  has_one :company, dependent: :destroy

  # validations
  validates :name, :email, :password, presence: true
  validates :password, length: { minimum: 8 }

  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :job_seeker

  # enums
  enum :role, { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum :status, { active: 0, non_active: 1 }
end