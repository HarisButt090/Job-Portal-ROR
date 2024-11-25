class User < ApplicationRecord
  # Devise configurations
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
  enum :role, { job_seeker: 0, company_admin: 1, employer: 2, super_admin: 3 }
  enum :status, { active: 0, non_active: 1 }

  # Callbacks
  before_update :accept_invitation, if: :password_and_invitation_valid?

  # Devise hook to update status after login
  def after_database_authentication
    Rails.logger.info("after_database_authentication hook triggered.")
    if invitation_accepted_at.present? && status == "non_active"
      update!(status: :active)
    end
  end

  # Check if the invitation is pending
  def invitation_pending?
    invitation_accepted_at.nil?
  end

  private

  # Callback to set invitation acceptance details
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

  # Ensure password validation is required only for new records or password changes
  def password_required?
    new_record? || password.present?
  end
end
