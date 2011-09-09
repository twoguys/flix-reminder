# Load the rails application
require File.expand_path('../application', __FILE__)


# Load ENV vars from local file
env_file = File.join(Rails.root, 'config', 'env.rb')
load(env_file) if File.exists?(env_file)

if Rails.env == "development"
  local_env_file = File.join(Rails.root, 'config', 'env.local.rb')
  load(local_env_file) if File.exists?(local_env_file)
end

# Initialize the rails application
FlixReminder::Application.initialize!
