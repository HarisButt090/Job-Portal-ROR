class User < ApplicationRecord
  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy
  belongs_to :company, optional: true

  enum role: { company_admin: 0, employer: 1, job_seeker: 2 }
  enum status: { active: 0, non_active: 1 }
end
