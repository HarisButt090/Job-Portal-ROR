class Company < ApplicationRecord
  # associations
  belongs_to :user
  validates :company_name, presence: true
  validates :industry, presence: true
  validates :employee_size, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  validates :address, presence: true

  has_many :employers, dependent: :destroy
  has_many :jobs, dependent: :destroy

  # validations
  validates :name, :industry, :address, presence: true
  validates :employee_size, presence: true,  numericality: { only_integer: true, greater_than: 0 }
end
