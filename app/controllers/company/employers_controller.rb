class Company::EmployersController < ApplicationController
  layout "company"
  before_action :set_company

  def create
    if @company.nil?
      flash[:alert] = 'No associated company found. Please contact the administrator.'
      redirect_to company_dashboard_path and return
    end

    # Create the user and assign the role of 'employer'
    @user = User.invite!(user_params) do |u|
      u.role = :employer
    end

    if @user.persisted?
      begin
        # Create the Employer record, keeping the correct company association
        Employer.create!(
          user: @user,
          company: @company,  # Ensure the Employer belongs to the correct company
          joined_date: Date.current
        )

        # No need to update the user's company here, just create the employer
        @user.invite! if @user.invitation_token.present?

        flash[:notice] = 'Employer invited successfully! An email has been sent for password setup.'
        redirect_to company_dashboard_path
      rescue ActiveRecord::RecordInvalid => e
        flash.now[:alert] = "Failed to create employer: #{e.message}"
        render :new
      end
    else
      flash.now[:alert] = 'Failed to invite employer. Please check the details.'
      render :new
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def user_params
    params.require(:user).permit(:name, :email, :contact_no)
  end
end
