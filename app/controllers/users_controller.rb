class UsersController < ApplicationController

  before_action :check_admin, only: [:index]
  
  def index
  end

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

    def check_admin
      redirect_to root_url unless current_user && current_user.admin
    end
end
