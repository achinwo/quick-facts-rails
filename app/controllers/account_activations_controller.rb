class AccountActivationsController < ApplicationController
  
  def new
  	user = User.find_by(email: params[:email])
  	if user and user.activated
  		flash[:warning] = "User #{user.name} is already activated!"
  	elsif user
  		user.create_account_activation_digest
  		user.send_account_activation_email
      	message = "Account activation instructions have sent to #{user.email}. "
      	message += "<a href='#{new_account_activation_url(email: user.email)}'>Re-send?</a>"
      	flash[:success] = message
    else
    	flash[:danger] = "Invalid email"
  	end
  	redirect_to root_url
  end

  def edit
  	user = User.find_by(email: params[:email])
  	token = params[:id]
  	if user && !user.activated && user.authenticated?(:activation, token)
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
