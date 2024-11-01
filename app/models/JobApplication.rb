class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :job_seeker
  has_many :interviews, dependent: :destroy

  enum status: { screened: 0, accepted: 1, denied: 2 }
end
