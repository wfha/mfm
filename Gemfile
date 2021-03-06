source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'

platforms :jruby do
  #gem 'jruby-openssl'
  gem 'activerecord-jdbcpostgresql-adapter' # Database Postgresql in Java
  gem 'therubyrhino', :group => :assets
  gem "rmagick4j", "~> 0.3.7", :group => :assets
  gem "warbler", "~> 1.3.6"
end

platforms :ruby do
  gem 'pg', '~> 0.14.1' # Database Postgresql
  gem 'unicorn', '~> 4.4.0' # Ruby Server
  gem 'rmagick', '~> 2.13.1', :group => :assets
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails', '~> 1.0.3'
  gem 'bootstrap-sass', '~> 2.3.0.1'

  gem 'carrierwave', '~> 0.8.0'
  gem 'fog', '~> 1.9.0'

  # Geo Info
  gem 'geocoder', '~> 1.1.5'
  gem 'gmaps4rails', '~> 1.5.6'
end

gem 'jquery-rails', '~> 2.1.4'
gem 'jquery_mobile_rails', '~> 1.3.0'
gem 'bootstrap-datepicker-rails', '~> 1.0.0.2'

# Deployment
gem 'capistrano', '~> 2.13.5'
gem 'rvm-capistrano', '~> 1.2.7'

# User system
gem 'devise', '~> 2.1.2'
gem 'cancan', '~> 1.6.8'
#gem 'rails_admin', '~> 0.4.3' # Too Heavy

# Form and Validation
gem 'simple_form', '~> 2.0.4'
gem 'simple_form_fancy_uploads', '~> 0.0.2'
gem 'client_side_validations', '~> 3.2.1'
gem 'client_side_validations-simple_form', '~> 2.0.1'
gem 'nested_form', '~> 0.3.1'

# Must be outside of assets
gem 'coffee-rails', '~> 3.2.1'
gem 'uglifier', '>= 1.0.3'

# Allows you to use render :new, :alert => 'You messed up'
gem 'flash_render', '~> 1.0.1'

# Third Part Service
gem 'savon', '~> 2.0.2'
#gem 'tropo-webapi-ruby', '~> 0.1.11' # Only for Tropo scripting
gem 'yelp', '0.0.0', :git => 'git://github.com/wfha/yelp.git'
#gem 'google_places', '~> 0.9.1'
gem 'rest-client', '~> 1.6.7'
gem 'twilio-ruby', '~> 3.9.0'

gem 'omniauth', '~> 1.1.3'
gem 'omniauth-facebook', '~> 1.4.1'
#gem 'omniauth-twitter', '~> 0.0.16'
gem 'omniauth-google-oauth2', '~> 0.1.13'
gem 'koala', '~> 1.6.0'

# Background Jobs
gem 'delayed_job_active_record', '~> 0.3.3'
gem 'delayed_job_web', '~> 1.1.2'
gem 'daemons', '~> 1.1.9'

# Payment
gem 'money', '~> 5.1.0'
gem 'activemerchant', '~> 1.29.3'
#gem 'braintree', '~> 2.22.0'

gem 'time_of_day', '~> 0.1.1'

# Memory, Log, Sql Analysis and Monitoring
gem 'newrelic_rpm'
gem 'oink', '~> 0.10.1'
gem 'request-log-analyzer', '~> 1.12.8'

# Pagination
gem 'kaminari', '~> 0.14.1'