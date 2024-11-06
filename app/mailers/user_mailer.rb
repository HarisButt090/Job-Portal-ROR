# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: "no-reply@yourdomain.com"  # Use your own sender address

  def verification_email(user)
    @user = user
    @url  = verify_email_url(token: @user.confirmation_token)  # Assuming you have this URL helper set up
    mail(to: @user.email, subject: "Verify Your Email")
  end
end
