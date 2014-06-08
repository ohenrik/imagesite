class NewUserMailWorker
  include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id)
	user.new_user_mail
  end
end