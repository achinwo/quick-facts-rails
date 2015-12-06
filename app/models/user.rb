class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

	has_many :facts
	has_secure_password

	validates :name, presence: true, length: {maximum: 50}
	validates :password, presence: true, length: {minimum: 6}
	validates :email, presence: true, length: {maximum: 255},
				format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive: false}

	attr_accessor :password_reset_token

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def create_password_reset_digest
		@password_reset_token = User.new_token
		update_attributes(password_reset_digest: User.digest(@password_reset_token),
						  password_reset_sent_at: Time.zone.now)
	end
end
