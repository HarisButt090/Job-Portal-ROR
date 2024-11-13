class User < ApplicationRecord
<<<<<<< HEAD
<<<<<<< HEAD
  # devise configuration in user model
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # associations
=======
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
=======
  # devise configurations
>>>>>>> 3208549 (Company registration using namespaces)
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :validatable
>>>>>>> a05a5ac (Configured devise)
=======
         :recoverable, :rememberable, :validatable,
         :confirmable

<<<<<<< HEAD
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }

>>>>>>> fcd77f3 (Company Registration through devise and redirecting to dashboard)
=======
  # associations
>>>>>>> 3208549 (Company registration using namespaces)
  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy
  has_one :company, dependent: :destroy

  # validations
  validates :name, :email, :password, presence: true
  validates :password, length: { minimum: 8 }

  accepts_nested_attributes_for :company

  # enums
  enum :role, { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum :status, { active: 0, non_active: 1 }
end
