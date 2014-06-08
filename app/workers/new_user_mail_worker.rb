class NewUserMailWorker
  include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id)
	user.generate_token(:confirm_email_token)
	user.confirm_email_sent_at = Time.zone.now
	user.save!
	UserMailer.new_user(user.id).deliver 
  end
end