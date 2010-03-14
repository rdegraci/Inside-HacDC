# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'rubygems'
gem 'twitter4r', '>=0.3.0'
require 'twitter'
require 'time'
require 'yaml'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'd4fcec7b91f79167e5569d14929894d8'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  CONFIG = YAML.load_file '/usr/local/rails/insidehacdc/config/twitter.yml'

  TWITTERLOGIN = CONFIG['username'] 
  TWITTERPASS = CONFIG['password']

  OCCUPANTSALT = CONFIG['salt']

  @@twitter_client = Twitter::Client.new(:login => TWITTERLOGIN, :password => TWITTERPASS)
  
  def twitter_client
    @@twitter_client
  end
 
  def salt 
    OCCUPANTSALT
  end
  
end

