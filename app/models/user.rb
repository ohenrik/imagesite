class User < ActiveRecord::Base
	has_secure_password

	after_create :create_schema
	


	validates :username, :subdomain, :email, presence: true, uniqueness: true

	# Or with your own reserved names
	validates  :subdomain, :subdomain  => { :reserved => %w(example documentation doc ole olehenrik anette lobach loebach skogstrom morgenstern help business) }

	before_create { generate_token(:auth_token) }

	has_and_belongs_to_many :roles
	has_many :photos
	has_many :themes
	belongs_to :theme
	belongs_to :home, polymorphic: true


	liquid_methods :first_name, :last_name, :username, :email, :site_title, :site_tagline


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

	def full_name
		[self.first_name, self.last_name].join(" ")
	end


	def created_at_unix
	  self.created_at.to_i
	end


	def is_admin?
		self.roles.find_by_role("admin").nil?
	end

	def is_member?
		self.roles.find_by_role("member").nil?
	end

	def is_premium?
		self.roles.find_by_role("premium").nil?
	end

	def is_trail?
		self.roles.find_by_role("trail").nil?
	end

	def is_guest?
		self.roles.find_by_role("guest").nil?
	end



end
