class Company < ApplicationRecord
  has_many :employers, dependent: :destroy
  has_many :jobs, through: :employers
  belongs_to :user
end
