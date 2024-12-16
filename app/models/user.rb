class User < ApplicationRecord
  # Devise configurations
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :invitable,
         :jwt_authenticatable , jwt_revocation_strategy: JwtDenylist 

    belongs_to :invited_by, class_name: 'User', optional: true

  # Associations
  has_one :job_seeker, dependent: :destroy
  has_one :recruiter, dependent: :destroy
  has_one :company, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, if: :password_required?

  # Enums
  enum :role, { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum :status, { active: 0, non_active: 1 }

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
