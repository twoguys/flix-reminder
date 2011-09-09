require 'flixy/version'


module Flixy
  # Defines constants and methods related to configurationmostly taken from the Twitter gem
  # 
  # Mostly taken from the Twitter Gem 
  # https://github.com/jnunemaker/twitter/blob/master/lib/twitter/configuration.rb
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :consumer_key,
      :consumer_secret,
      :endpoint,
      :format,
      :gateway,
      :oauth_token,
      :oauth_token_secret,
      :proxy,
      :search_endpoint,
      :user_agent].freeze

      # The adapter that will be used to connect if none is set
      DEFAULT_ADAPTER = :net_http

      # By default, don't set an application key
      DEFAULT_CONSUMER_KEY = nil

      # By default, don't set an application secret
      DEFAULT_CONSUMER_SECRET = nil

      # The endpoint that will be used to connect if none is set
      #
      # @note This is configurable in case you want to use HTTP instead of HTTPS, specify a different API version, or use a Twitter-compatible endpoint.
      # @see http://status.net/wiki/Twitter-compatible_API
      # @see http://en.blog.wordpress.com/2009/12/12/twitter-api/
      # @see http://staff.tumblr.com/post/287703110/api
      # @see http://developer.typepad.com/typepad-twitter-api/twitter-api.html
      DEFAULT_ENDPOINT = 'http://api.netflix.com'.freeze

      # The response format appended to the path and sent in the 'Accept' header if none is set
      #
      # @note JSON is preferred over XML because it is more concise and faster to parse.
      DEFAULT_FORMAT = :xml

      # By default, don't set a user oauth token
      DEFAULT_OAUTH_TOKEN = nil

      # By default, don't set a user oauth secret
      DEFAULT_OAUTH_TOKEN_SECRET = nil

      # By default, don't use a proxy server
      DEFAULT_PROXY = nil

      # The value sent in the 'User-Agent' header if none is set
      DEFAULT_USER_AGENT = "Flixy Ruby Gem #{Flixy::VERSION}".freeze

      DEFAULT_GATEWAY = nil

      # @private
      attr_accessor *VALID_OPTIONS_KEYS

      # When this module is extended, set all configuration options to their default values
      def self.extended(base)
        base.reset
      end

      # Convenience method to allow configuration options to be set in a block
      def configure
        yield self
      end

      # Create a hash of options and their values
      def options
        options = {}
        VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
        options
      end

      # Reset all configuration options to defaults
      def reset
        self.adapter            = DEFAULT_ADAPTER
        self.consumer_key       = DEFAULT_CONSUMER_KEY
        self.consumer_secret    = DEFAULT_CONSUMER_SECRET
        self.endpoint           = DEFAULT_ENDPOINT
        self.format             = DEFAULT_FORMAT
        self.oauth_token        = DEFAULT_OAUTH_TOKEN
        self.oauth_token_secret = DEFAULT_OAUTH_TOKEN_SECRET
        self.proxy              = DEFAULT_PROXY
        self.user_agent         = DEFAULT_USER_AGENT
        self.gateway            = DEFAULT_GATEWAY
        self
      end
    end
end
