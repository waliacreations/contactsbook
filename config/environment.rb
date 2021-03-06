# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')


  if Gem::VERSION >= "1.3.6" 
  module Rails
  class GemDependency
  def requirement
  r = super
  (r == Gem::Requirement.default) ? nil : r
  end
  end
  end
  end


Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  ####### HTTPOnly cookiesfor disabling javascript use for sessions
  #config.action_controller.session = {
 # :session_key => ‘_session_id’,
  #:session_http_only => true,       ####### HTTPOnly cookiesfor disabling javascript use for sessions
  #:secret      => ‘walia’
  #}
  
  config.gem "moonshado-sms"
  
  
  # Set to one of [:active_record_store, :drb_store, :mem_cache_store, :cookie_store]  
 # config.action_controller.session_store = :cookie_store
  
 config.action_mailer.delivery_method = :smtp  ### to use gmail or sendgrid
   ### to use gmail or sendgrid
  config.action_mailer.default_content_type = "text/html"
 
  
  config.action_mailer.delivery_method = :smtp 
  config.action_mailer.smtp_settings = { 
  :enable_starttls_auto => :true, 
  :address => "smtp.gmail.com", 
  :port => 587, 
  :domain => ENV['GMAIL_SMTP_USER'],
  :authentication => :plain, 
  :user_name => ENV['GMAIL_SMTP_USER'],
  :password => ENV['GMAIL_SMTP_PASSWORD'], 
  :tls => :true 
  } 
  config.action_mailer.perform_deliveries = :true 
  config.action_mailer.raise_delivery_errors = :true 
  config.action_mailer.default_charset = "utf-8"
  
  
  
  
  
  
  
  
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end