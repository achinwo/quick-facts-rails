class AccountActivationsController < ApplicationController
  def edit
  	user = User.find_by(email: params[:email])
  	token = params[:id]
  	if user && !user.activated && user.authenticate?(:activation, token)
  		user.activate_account
  		log_in_user user
  		flash[:success] = "Welcome #{user.name}, your account is now activated"
  		redirect_to root_url
  	else
  		flash[:danger] = "Invalid activation link"
      	redirect_to root_url
  	end
  end
end
