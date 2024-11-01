class Interview < ApplicationRecord
  belongs_to :job_application

  enum status: { scheduled: 0, completed: 1, cancelled: 2 }
end
