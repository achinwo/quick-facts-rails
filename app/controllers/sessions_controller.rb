class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email:params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		log_in_user user
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Authentication failed"
  		render 'new'
  	end
  end

  def destroy
  	session.delete :id
  	redirect_to root_url
  end
end
