class CreateSchemaWorker
  include Sidekiq::Worker

  def perform(user_id)
	user = User.find(user_id)
	user.class.connection.execute("create schema tenant#{user.id}")
	scope_schema do
		load Rails.root.join("db/schema.rb")
		user.class.connection.execute("drop table #{user.class.table_name}")
	end
  end
end