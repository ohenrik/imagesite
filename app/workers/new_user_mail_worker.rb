class NewUserMailWorker
  include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id)
	user.generate_token(:confirm_email_token)
	user.confirm_email_sent_at = Time.zone.now
	user.save!
	user.send_new_user_email 
  end
end