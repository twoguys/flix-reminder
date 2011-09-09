require 'rubygems'
require 'faraday'
require 'faraday_middleware'
require 'simple_oauth'

CONSUMER_KEY        = "daf4yaewmfqn99f4pjqaems6"
CONSUMER_SECRET     = "ucVXuPdrB2"
OAUTH_TOKEN         = "BQAJAAEDEPosQ1qPsNx2owhZ2228hUww9pzbwjij-zH2kmURp-0NUbD5hSeyqMs6hfcW9Q9lYSEhb7ZPAMgZTo8gRhprfmXC"
OAUTH_TOKEN_SECRET  = "Nq4tQt7Prqsn"

auth = {
  :consumer_key     => CONSUMER_KEY,
  :consumer_secret  => CONSUMER_SECRET,
  :token            => OAUTH_TOKEN,
  :token_secret     => OAUTH_TOKEN_SECRET
}

HOST = "http://api.netflix.com"
PATH = "/users/T1uHQrV6AnLRiLRJWZgYiTffg7vhBrfXqHU9_HaninzPw-/queues/disc"

conn = Faraday.new(:url => HOST) do |builder|
  builder.use Faraday::Adapter::NetHttp

  builder.use Faraday::Request::UrlEncoded
  # builder.use Faraday::Request::OAuth, auth
  
  # builder.use Faraday::Response::Logger
  #builder.use Faraday::Response::Mashify
  builder.use Faraday::Response::ParseXml
end

header = SimpleOAuth::Header.new(
  "GET", 
  "#{HOST}#{PATH}", 
  nil, 
  {
    :consumer_key     => CONSUMER_KEY,
    :consumer_secret  => CONSUMER_SECRET,
    :token            => OAUTH_TOKEN,
    :token_secret     => OAUTH_TOKEN_SECRET
  }
)
#puts header.signed_attributes.to_yaml

opts = {}
opts[:oauth_consumer_key]       = CONSUMER_KEY
opts[:oauth_nonce]              = header.signed_attributes[:oauth_nonce]
opts[:oauth_signature_method]   = "HMAC-SHA1"
opts[:oauth_timestamp]          = header.signed_attributes[:oauth_timestamp] 
opts[:oauth_token]              = OAUTH_TOKEN
opts[:oauth_version]            = "1.0"
opts[:oauth_signature]          = header.signed_attributes[:oauth_signature]

#puts opts.to_yaml

response = conn.get do |req|
  req.url PATH, header.signed_attributes
end

puts response.body.to_yaml
