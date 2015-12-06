module SessionsHelper

	def current_user
		if (user_id = session[:user_id])
			@current_user = @current_user || User.find(user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find(user_id)
			if user && user.authenticated?(:remember_me, cookies[:remember_me_token])
				log_in_user user
				@current_user = user
			end
		end
	end

	# Returns true if the given user is the current user.
  	def current_user?(user)
    	user == current_user
  	end

	def log_in_user(user)
		session[:user_id] = user.id
	end

	def remember_user(user)
		user.create_remember_me_digest
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_me_token] = user.remember_me_token
	end

	def forget_user(user)
		cookies.delete :user_id
		cookies.delete :remember_me_token
		user.update_attribute(:remember_me_digest, nil)
	end

	def log_out_user
		forget_user current_user
	    session.delete :user_id
	    @current_user = nil
	end

	def logged_in?
		!!current_user
	end

	def any_facts?
		current_user && current_user.facts.any?
	end

end
