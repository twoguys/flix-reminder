require 'multi_xml'
require 'faraday'
require 'faraday_middleware'
require 'simple_oauth'
require 'faraday/request/oauth_params'
require 'flixy/configuration'
require 'flixy/api'
require 'flixy/box_art'
require 'flixy/item'
require 'flixy/queue'
require 'flixy/user'

module Flixy
  extend Configuration

  class << self
    def user(user_id, oauth_token, oauth_token_secret)
      User.new
    end
  end
 
end
