class User < ApplicationRecord
  # devise configurations
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :invitable

  # Associations
  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy
  has_one :company, dependent: :destroy

  # Validations
  validates :name, :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }, if: :password_required?

  # Enums
  enum role: { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum status: { active: 0, non_active: 1 }

  private

  def password_required?
    new_record? || password.present?
  end
end
