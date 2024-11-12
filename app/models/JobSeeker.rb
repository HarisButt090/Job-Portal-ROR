class JobSeeker < ApplicationRecord
  # associations
  belongs_to :user

  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  has_many :job_seeker_skills, dependent: :destroy
  has_many :skills, through: :job_seeker_skills

  has_many :job_applications, dependent: :destroy
  has_many :interviews, through: :job_applications


  # enums
  enum preferred_job_type: { on_site: 0, hybrid: 1, remote: 2 }
end
