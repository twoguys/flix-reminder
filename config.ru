# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
# run FlixReminder::Application
require 'resque/server'


# Set the AUTH env variable to your basic auth password to protect Resque.
#AUTH_PASSWORD = ENV['AUTH']
#if AUTH_PASSWORD
#  Resque::Server.use Rack::Auth::Basic do |username, password|
#    password == AUTH_PASSWORD
#  end
#end


run Rack::URLMap.new \
  "/"       => FlixReminder::Application, 
  "/resque" => Resque::Server.new
