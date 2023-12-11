class UserMailer < ApplicationMailer
    def welcome_email(email)
      mail(to: email, subject: 'Welcome to the Aggieland Art Trail')
    end
    def forgot_password(user)
      @user = user
      @token = user.signed_id(purpose: "password_reset", expires_in: 15.minutes)
      mail(to: user.email, subject: 'Reset your password')
    end
end
