class Interview < ApplicationRecord
  # associations
  belongs_to :job_application

  #validations
  validates :scheduled_at, presence: true

  # enums
  enum status: { scheduled: 0, completed: 1, cancelled: 2 }
end