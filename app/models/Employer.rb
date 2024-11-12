class Employer < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :company

  has_many :jobs, dependent: :destroy
end
