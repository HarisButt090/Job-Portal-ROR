class Job < ApplicationRecord
  # associations
  belongs_to :employer
  belongs_to :company

  has_many :job_applications, dependent: :destroy

  # enums
  enum display_status: { draft: 0, published: 1, archived: 2 }
  enum job_status: { closed: 0, active: 1 }
  enum job_type: { on_site: 0, hybrid: 1, remote: 2 }
end
