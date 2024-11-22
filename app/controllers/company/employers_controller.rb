class Company::EmployersController < ApplicationController
  def create
    company = current_user.company

    @user = User.invite!(user_params) do |u|
      u.role = :employer
    end

    if @user.persisted?
      Employer.create!(
        user: @user,
        company: company,
        joined_date: Date.current
      )

      @user.company = company
      @user.save!

      @user.invite! if @user.invitation_token.present?

      flash[:notice] = 'Employer invited successfully! An email has been sent for password setup.'
      redirect_to company_dashboard_path
    else
      flash.now[:alert] = 'Failed to invite employer. Please check the details.'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :contact_no)
  end
end
