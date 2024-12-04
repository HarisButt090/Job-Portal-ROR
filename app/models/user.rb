class User < ApplicationRecord
  # Devise configurations
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable

  # Associations
  has_one :job_seeker, dependent: :destroy
  has_one :recruiter, dependent: :destroy
  has_one :company, dependent: :destroy

  # Validations
  validates :name, :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }, if: :password_required?

  # Enums
  enum :role, { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum :status, { active: 0, non_active: 1 }

  # Callbacks
  before_update :accept_invitation, if: :password_and_invitation_valid?

  def after_database_authentication
    Rails.logger.info("after_database_authentication hook triggered.")
    if invitation_accepted_at.present? && status == "non_active"
      update!(status: :active)
    end
  end

  def invitation_pending?
    invitation_accepted_at.nil?
  end

  def company
    if role == "company_admin"
      Company.find_by(user_id: id)
    elsif role == "employer"
      employer&.company
    else
      nil
    end
  end
  

  private

  def password_and_invitation_valid?
    Rails.logger.info("Checking invitation and password conditions...")
    Rails.logger.info("invitation_accepted_at: #{invitation_accepted_at}, saved_change_to_encrypted_password?: #{saved_change_to_encrypted_password?}")
    invitation_accepted_at.nil? && saved_change_to_encrypted_password?
  end

  def accept_invitation
    Rails.logger.info("Accepting invitation...")
    self.invitation_accepted_at = Time.current
    self.status = :active
  end

  def password_required?
    new_record? || password.present?
  end
end