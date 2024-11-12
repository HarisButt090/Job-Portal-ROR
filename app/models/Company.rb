class Company < ApplicationRecord
  # associations
  belongs_to :user

  has_many :employers, dependent: :destroy
  has_many :jobs, dependent: :destroy
end
