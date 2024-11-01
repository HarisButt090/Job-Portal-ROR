class Job < ApplicationRecord
  belongs_to :employer
  has_many :job_applications, dependent: :destroy

  enum display_status: { draft: 0, published: 1, rejected: 2 }
  enum status: { active: 0, closed: 1 }
end
