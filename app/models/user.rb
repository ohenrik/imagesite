require "paymill"
class User < ActiveRecord::Base

	# create schema
	after_create :create_schema

	has_secure_password

	validates :username, :subdomain, :email, presence: true, uniqueness: true

	# Or with your own reserved names
	validates  :subdomain, :subdomain  => { :reserved => %w(example image documentation doc ole olehenrik anette lobach loebach skogstrom morgenstern help business mail docs) }

	before_create { generate_token(:auth_token) }

	has_and_belongs_to_many :roles
	has_many :photos
	has_many :themes
	has_many :public_themes
	has_many :user_credit_cards
	belongs_to :theme
	belongs_to :home, polymorphic: true


	liquid_methods :first_name, :last_name, :username, :email, :site_title, :site_tagline, :theme

	def create_client(description = nil)
		paymill_response = Paymill::Client.create(email: self.email, description: description)
		self.client_token = paymill_response.id
		self.save
	end

	def add_credit_card(token)
		payment_object = Paymill::Payment.create token: token, client: self.client_token

		self.user_credit_cards.create payment_token: payment_object.id, 
			card_type: payment_object.card_type, 
			country: payment_object.country, 
			expire_month: payment_object.expire_month.to_i,
			expire_year: payment_object.expire_year.to_i,
			last4: payment_object.last4
		 
	end

	def charge_credit_card(amount, card = self.user_credit_cards.first.payment_token)
		Paymill::Transaction.create amount: amount, 
		currency: "USD",
	    client: self.client_token,
	    payment: card,
	    description: "Test Transaction"
	end

	def purchase_product()
		#Paymill::Transaction.create amount: 4200, currency: "EUR", client: "client_c781b1d2f7f0f664b4d9", payment: "pay_2f82a672574647cd911d", description: "Test Transaction"
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self)
	end

	def send_new_user_email
		UserMailer.new_user(self.id)
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	# Multitenancy! 
	def create_schema
		self.class.connection.execute("create schema tenant#{self.id}")
		self.scope_schema do
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
		[self.try(:first_name), self.try(:last_name)].join(" ")
	end


	def created_at_unix
	  self.created_at.to_i
	end

	%w[member admin premium trail].each do |is_role|
		define_method("#{is_role}?") do 
			return true if self.roles.where(role: is_role).present?
		end
	end



end
