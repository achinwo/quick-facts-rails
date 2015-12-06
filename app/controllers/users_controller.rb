class UsersController < ApplicationController



  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_account_activation_email
      flash[:success] = "Account activation instructions have sent to #{@user.email}"
  		redirect_to root_url
  	else
      puts "ERRORS: #{@user.errors.full_messages}"
  		render 'new'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
