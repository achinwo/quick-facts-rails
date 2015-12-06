class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email:params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
      if user.activated
  		  log_in_user user
        params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
  		  redirect_to root_url
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link. "
        message += "<a href='#{new_account_activation_url(email: user.email)}'>Re-send?</a>"
        flash[:warning] = message
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
  	end
  end

  def destroy
  	log_out_user if logged_in?
    redirect_to root_url
  end
end
