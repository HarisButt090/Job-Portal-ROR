class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :validatable
=======
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }

>>>>>>> ee28dd6 (Company Registration through devise and redirecting to dashboard)
  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy
  has_one :company, dependent: :destroy

  accepts_nested_attributes_for :company

  enum role: { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum status: { active: 0, non_active: 1 }
end
