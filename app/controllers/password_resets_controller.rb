class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    puts "Hit Create!!"
    email = params[:password_reset][:email]
  	user = User.find_by(email: email.downcase)
  	if user
      user.create_password_reset_digest
      user.send_password_reset_email
  		flash[:success] = "Password reset instruction send to #{email}"
  		redirect_to root_path
  	else
  		flash.now[:danger] = "#{email} is not registered email"
  		render 'new'
  	end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in_user @user
      flash[:success] = "Password has been reset."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end
end
