class JobApplication < ApplicationRecord
  # Associations
  belongs_to :job
  belongs_to :job_seeker

  has_many :interviews, dependent: :destroy

  # Enums for application status
  enum :status, { pending: 0, screened: 1, accepted: 2, denied: 3 }

end
