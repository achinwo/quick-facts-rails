module SessionsHelper

	def current_user
		if (id = session[:id])
			@current_user = @current_user || User.find(id)
		end
	end

	def log_in_user(user)
		session[:id] = user.id
	end

end
