class Company < ApplicationRecord
  validates :company_name, presence: true
  validates :industry, presence: true
  validates :employee_size, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  validates :address, presence: true

  has_many :employers, dependent: :destroy
  has_many :jobs, through: :employers
end
