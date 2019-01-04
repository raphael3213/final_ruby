module SessionHelper

	def log_in(user)
	session[:user_id]=user.id
	end
	
	def current_user
	
		if session[:user_id]
		@current_user ||= User.find_by(id: session[:user_id])
		elsif cookies.signed[:user_id]
		@current_user = User.find_by(id: cookies.signed[:user_id])
			if @current_user.authenticated?(cookies[:token_digest])
			@current_user
			end
			
		end
		
	end
	
	def logged_in?
	!current_user.nil?
	end
	
	def log_out
	forget(current_user)
		session.delete(:user_id)
		
		@current_user = nil
	end
	
	def remember (user)
	user.remember
	cookies.permanent.signed[:user_id]=user.id
	cookies.permanent[:token_digest]=user.remember_token
	end
	
	def forget(user)
  user.forget
  cookies.delete(:user_id)
  cookies.delete(:remember_token)
  end
	
end
