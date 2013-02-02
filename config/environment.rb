# Load the rails application
require File.expand_path('../application', __FILE__)

# Load the app_config.yml file
APP_CONFIG = YAML.load_file(Rails.root.join('config', 'app_config.yml'))[Rails.env]

# Initialize the rails application
Mfm::Application.initialize!
