class JobSeeker < ApplicationRecord
  # associations
  belongs_to :user

  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  has_many :job_seeker_skills, dependent: :destroy
  has_many :skills, through: :job_seeker_skills

  has_many :job_applications, dependent: :destroy
  has_many :interviews, through: :job_applications

  # attachments
  has_one_attached :resume

  # Validations
  validates :city, :address, :preferred_job_type, presence: true
  validates :resume, attached: true, content_type: [ "application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document" ], size: { less_than: 5.megabytes }

  # enums
  enum preferred_job_type: { on_site: 0, hybrid: 1, remote: 2 }
end
