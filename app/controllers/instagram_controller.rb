# app/controllers/instagram_controller.rb
class InstagramController < ApplicationController
    def connect
      redirect_to "/auth/facebook"
    end
  
    def callback
      auth_info = request.env['omniauth.auth']
      current_user.update(
        instagram_uid: auth_info.uid,
        instagram_token: auth_info.credentials.token
      )
      redirect_to current_user_path, notice: "Instagram connected successfully!"
    end
  
    def disconnect
      current_user.update(instagram_uid: nil, instagram_token: nil)
      redirect_to current_user_path, notice: "Instagram disconnected successfully!"
    end
  end
  