class SessionsController < ApplicationController
    def omniauth
      user = User.from_omniauth(request.env['omniauth.auth'])
      if user.persisted?
        sign_in_and_redirect user, notice: "Connected to Instagram!"
      else
        redirect_to root_path, alert: "There was an issue connecting to Instagram."
      end
    end
  end
  