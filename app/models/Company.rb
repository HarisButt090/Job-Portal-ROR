class Company < ApplicationRecord
  has_many :employers, dependent: :destroy
  has_many :jobs, dependent: :destroy
  belongs_to :user
end
