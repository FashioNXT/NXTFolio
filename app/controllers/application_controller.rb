class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def index
    puts "Session key"
    puts session[:current_user_key].to_s
  end
end
