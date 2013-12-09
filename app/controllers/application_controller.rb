class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :verify_authenticity_token
  helper_method :current_user

  def current_user
   	@current_user = User.find(session[:current_user]) if session[:current_user]
   	return @current_user
  end
end
