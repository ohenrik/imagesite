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

  def new_user(user_id)
    @user = User.find(user_id)
    mail :to => @user.email, :subject => "Welcome to Theatrical.co"
  end


  def contact(email, subject, message)
    @message = message
    mail :to => email, :subject => (subject || "Message from Theatrical.co")
  end
  
end
