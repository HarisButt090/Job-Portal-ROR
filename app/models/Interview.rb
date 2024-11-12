class Interview < ApplicationRecord
  # associations
  belongs_to :job_application
  # enums
  enum status: { scheduled: 0, completed: 1, cancelled: 2 }
end
