class User < ApplicationRecord
  # devise configurations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # associations
<<<<<<< HEAD
=======
=======
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :validatable
>>>>>>> a05a5ac (Configured devise)
=======
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }

>>>>>>> fcd77f3 (Company Registration through devise and redirecting to dashboard)
>>>>>>> 407dc42 (Company Registration through devise and redirecting to dashboard)
  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy
  has_one :company, dependent: :destroy

<<<<<<< HEAD
  # validations
  validates :name, :email, :password, presence: true
  validates :password, length: { minimum: 8 }

  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :job_seeker

  # enums
  enum :role, { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum :status, { active: 0, non_active: 1 }
<<<<<<< HEAD
end
=======
=======
  accepts_nested_attributes_for :company

  enum role: { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum status: { active: 0, non_active: 1 }
>>>>>>> 407dc42 (Company Registration through devise and redirecting to dashboard)
end
>>>>>>> 3d83dc7 (:rebased company registration chnages with job seeker)
