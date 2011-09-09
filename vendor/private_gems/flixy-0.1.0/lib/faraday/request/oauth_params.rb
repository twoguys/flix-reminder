require 'faraday'

module Faraday
  class Request::OAuthParams < Faraday::Middleware
    dependency 'simple_oauth'

    def call(env)
      params        = env[:body] || {}
      
      header  = SimpleOAuth::Header.new(env[:method], env[:url], nil, @options)
      uri     = Addressable::URI.parse(env[:url])
    
      uri.query_values = {} if uri.query_values.nil?
      uri.query_values = uri.query_values.merge(header.signed_attributes)
              
      env[:url] = uri

      @app.call(env)
    end

    def initialize(app, options)
      @app, @options = app, options
    end
  end
end

# http://api.netflix.com/users/T1uHQrV6AnLRiLRJWZgYiTffg7vhBrfXqHU9_HaninzPw-?
# oauth_consumer_key=daf4yaewmfqn99f4pjqaems6&
# oauth_nonce=d7ce007dc3fefa342c00221dc3eb6abb&
# oauth_signature=kMpTbgYbQ4rCgGJj8r%2BBao9YBrc%3D&
# oauth_signature_method=HMAC-SHA1&
# oauth_timestamp=1313897295&
# oauth_token=BQAJAAEDEPosQ1qPsNx2owhZ2228hUww9pzbwjij-zH2kmURp-0NUbD5hSeyqMs6hfcW9Q9lYSEhb7ZPAMgZTo8gRhprfmXC&
# oauth_version=1.0
# 
# http://api.netflix.com/users/T1uHQrV6AnLRiLRJWZgYiTffg7vhBrfXqHU9_HaninzPw-?
# oauth_consumer_key=daf4yaewmfqn99f4pjqaems6&
# oauth_nonce=0d487ec0ae36f77870b913bd903d5ef4&
# oauth_signature_method=HMAC-SHA1&
# oauth_timestamp=1313897313&
# oauth_token=BQAJAAEDEPosQ1qPsNx2owhZ2228hUww9pzbwjij-zH2kmURp-0NUbD5hSeyqMs6hfcW9Q9lYSEhb7ZPAMgZTo8gRhprfmXC&
# oauth_version=1.0&
# oauth_signature=%2B8Ks4NC6zPECE4LFvzYQUXlQm7E%3D
