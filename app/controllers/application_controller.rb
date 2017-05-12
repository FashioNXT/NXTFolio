class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Used to confirm the session key of the current user
  def index
    puts "Session key"
    puts session[:current_user_key].to_s
  end
end
