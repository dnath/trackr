class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  @@i = 1

  def current_user
  	@current_user = User.find(session[:current_user]) if session[:current_user]
  	@@i += 1
  	puts @@i.to_s + " current_user = " + @current_user.to_s

  	return @current_user
  end
end
