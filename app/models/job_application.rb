class JobApplication < ApplicationRecord
  # Associations
  belongs_to :job
  belongs_to :job_seeker

  has_many :interviews, dependent: :destroy

  # Enums for application status
  enum :status, { pending: 0, screened: 1, accepted: 2, denied: 3 }

  # File attachment for CV
  has_one_attached :cv

  # Validations
  validates :total_experience, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be a non-negative number" }
  validates :last_organization, :latest_degree, :status , presence: true
  validates :graduated_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: Time.now.year, message: "must be a valid year" }
  validates :cv, attached: true, content_type: ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'], size: { less_than: 5.megabytes }
end