module Flixy
  module API
    
    def get(path, params = {})
      connection.get do |req|
        req.url path, params
      end.body
    end
    
    def post(path, params = {})
      connection.post do |req|
        req.url path, params
      end.body
    end
    
    def connection
      auth = {
        :consumer_key     => Flixy.consumer_key,
        :consumer_secret  => Flixy.consumer_secret,
        :token            => Flixy.oauth_token,
        :token_secret     => Flixy.oauth_token_secret
      }

      conn = Faraday.new(:url => Flixy.endpoint) do |builder|
        builder.use Faraday::Request::OAuthParams, auth
        builder.use Faraday::Adapter::NetHttp

        builder.use Faraday::Request::UrlEncoded

        builder.use Faraday::Response::Logger
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseXml
      end
      conn
    end
  
  end
end