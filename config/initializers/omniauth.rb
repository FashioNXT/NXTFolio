Rails.application.config.middleware.use OmniAuth::Builder do
    provider :instagram, ENV['INSTAGRAM_CLIENT_ID'], ENV['INSTAGRAM_CLIENT_SECRET']
  end
  