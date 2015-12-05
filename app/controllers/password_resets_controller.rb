class PasswordResetsController < ApplicationController
  def new
  end

  def create
    puts "Hit Create!!"
    email = params[:password_reset][:email]
  	user = User.find_by(email: email)
  	if !user.nil?
      PasswordResetMailer.password_reset_email(user).deliver_later
  		flash[:success] = "Password reset instruction send to #{email}"
  		redirect_to root_path
  	else
  		flash.now[:danger] = "#{email} is not registered email"
  		render 'new'
  	end
  end
end
