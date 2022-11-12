OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :genius, ENV['GENIUS_CLIENT_ID'], ENV['GENIUS_CLIENT_SECRET']
end