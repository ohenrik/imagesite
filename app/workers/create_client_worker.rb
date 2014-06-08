class CreateClientWorker
  include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id)
	paymill_response = Paymill::Client.create(email: user.email, description: user.subdomain)
	user.client_token = paymill_response.id
	user.save!
  end
end