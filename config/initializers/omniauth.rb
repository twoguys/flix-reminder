require 'omniauth/core'
require 'omniauth/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :netflix, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end