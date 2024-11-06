class RegistrationsController < ApplicationController
  def new
    @user = User.new
    @user.build_company
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.verification_email(@user).deliver_later
        redirect_to verification_success_path
    else
      # Log user errors if saving fails
      Rails.logger.debug "User errors: #{@user.errors.full_messages}"
      render :new
    end
  end

  def verification_success
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation, :role,
      company_attributes: [ :company_name, :industry, :employee_size, :address ]
    )
  end
end
