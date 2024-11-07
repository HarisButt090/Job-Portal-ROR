class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy
  has_one :company, dependent: :destroy

  enum role: { job_seeker: 0,  company_admin: 1, employer: 2, super_admin: 3 }
  enum status: { active: 0, non_active: 1 }
end
