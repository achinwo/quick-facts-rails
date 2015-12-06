class UsersController < ApplicationController



  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_account_activation_email
      message = "Account activation instructions have sent to #{@user.email}. "
      message += "<a href='#{new_account_activation_url(email: @user.email)}'>Re-send?</a>"
      flash[:success] = message
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
