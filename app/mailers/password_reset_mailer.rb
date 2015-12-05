class PasswordResetMailer < ApplicationMailer
	default from: 'notifications@example.com'
	
	def password_reset_email(user)
		puts "LOGIN URL #{login_url}"
		@user = user
		@url = login_url
		mail(to: @user.email, subject: "Quick Facts: Password Reset")
	end
end
