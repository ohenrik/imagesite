class User < ActiveRecord::Base
	has_secure_password

	after_create :create_schema

	validates_uniqueness_of :email
	validates_uniqueness_of :subdomain

	validates :email, :username, :subdomain, presence: true

	before_create { generate_token(:auth_token) }

	has_and_belongs_to_many :roles
	has_many :photos
	has_many :themes
	belongs_to :theme


	liquid_methods :first_name, :last_name, :username, :email


	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	# Multitenancy! 
	def create_schema
	  self.class.connection.execute("create schema tenant#{id}")
	  scope_schema do
	    load Rails.root.join("db/schema.rb")
	    self.class.connection.execute("drop table #{self.class.table_name}")
	  end
	end

	def scope_schema(*paths)
	  original_search_path = self.class.connection.schema_search_path
	  self.class.connection.schema_search_path = ["tenant#{id}", *paths].join(",")
	  yield
	ensure
	  self.class.connection.schema_search_path = original_search_path
	end

end
