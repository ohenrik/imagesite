class CreateSchemaWorker
  include Sidekiq::Worker

  def perform(user_id)
  user = User.find(user_id)
  user.create_schema
  end
end