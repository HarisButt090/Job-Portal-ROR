# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: "haris@staunch.com"

  # Sends a verification email to the user after registration
  def verification_email(user)
    @user = user
    @confirmation_token = @user.confirmation_token
    @confirmation_url = user_confirmation_url(confirmation_token: @confirmation_token)

    mail(to: @user.email, subject: "Please Confirm Your Email Address")
  end
end
