module SessionsHelper

	def current_user
		if (id = session[:user_id])
			@current_user = @current_user || User.find(id)
		end
	end

	def log_in_user(user)
		session[:user_id] = user.id
	end

	def remember_user(user)
		user.remember
		cookie.permanent.signed[:user_id] = user.id
		cookie.permanent[:remember_token] = user.remember_token
	end

	def forget_user(user)
		cookie.permanent.signed.delete :user_id
		cookie.permanent.delete :remember_me_token
		user.update_atribute(:remember_me_digest, nil)
	end

	def log_out_user
		session.delete :user_id
		redirect_to root_url
	end

	def logged_in?
		!!current_user
	end

	def any_facts?
		current_user && current_user.facts.any?
	end

end
