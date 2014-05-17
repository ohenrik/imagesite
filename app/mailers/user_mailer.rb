class UserMailer < ActionMailer::Base
  default from: "noreply@theatrical.co"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def new_user(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to Theatrical.co"
  end

  
end
