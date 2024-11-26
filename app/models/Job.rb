class Job < ApplicationRecord
  # Associations
  belongs_to :employer, class_name: 'Employer', foreign_key: 'recruiter_id', optional: true
  belongs_to :company

  has_many :job_applications, dependent: :destroy

  # Validations
  validates :title, :address, :city, :job_description, :responsibilities, 
            :requirements, :experience, :qualification, :job_type, presence: true
  validates :salary, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Enums
  enum :displayed_status, { draft: 0, published: 1, archived: 2 }
  enum :job_status, { closed: 0, active: 1 }
  enum :job_type, { on_site: 0, hybrid: 1, remote: 2 }
end
