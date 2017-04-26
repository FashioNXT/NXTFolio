class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def index
    puts "Session key"
    puts session[:current_user_key].to_s
  end
  
  ### ADDED FOR BCRYPT ###
  # def current_user
  #   @current_user ||= LoginInfo.find(session[:user_key]) if session[:user_key]
  # end
  # helper_method :current_user

  # def authorize
  #   redirect_to '/login_info/login' unless current_user
  # end
end
