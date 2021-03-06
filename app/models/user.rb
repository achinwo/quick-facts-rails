class User < ActiveRecord::Base
	include Preferences
 
    preference :chime, false
    preference :name, "Josh"
    preference :awesome, true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

	has_many :facts
	has_many :groups
	has_many :variables
	
	has_secure_password

	validates :name, presence: true, length: {maximum: 50}
	validates :password, presence: true, length: {minimum: 6}
	validates :email, presence: true, length: {maximum: 255},
				format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive: false}

	attr_accessor :password_reset_token
	attr_accessor :activation_token
	attr_accessor :remember_me_token
	before_save :downcase_email
	before_create :create_account_activation_digest

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def authenticated?(property, token)
		digest = send("#{property}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def activate_account
		update_attribute(:activated, true)
  		update_attribute(:activated_at, Time.zone.now)
  	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def password_reset_expired?
		self.password_reset_sent_at < 2.hours.ago
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def send_account_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def create_password_reset_digest
		@password_reset_token = User.new_token
		update_attribute(:password_reset_digest, User.digest(@password_reset_token))
		update_attribute(:password_reset_sent_at, Time.zone.now)
	end

	def create_account_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(self.activation_token)
  		update_attribute(:activation_digest, self.activation_digest) if persisted?
	end

	def create_remember_me_digest
		self.remember_me_token = User.new_token
  		update_attribute(:remember_me_digest, User.digest(self.remember_me_token))
	end

	private

		def downcase_email
			self.email = email.downcase
		end
end
