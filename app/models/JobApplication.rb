class JobApplication < ApplicationRecord
  # associations
  belongs_to :job
  belongs_to :job_seeker

  has_many :interviews, dependent: :destroy

  # enums
  enum status: { pending: 0, screened: 1, accepted: 2, denied: 3 }
end
