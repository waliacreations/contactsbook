
source :rubygems
source :gemcutter
#gem "rails", "~> 2.3.5"
#gem "moonshado", "1.1.0"

#gem "moonshado-sms", :git => "http://github.com/moonshado/moonshado-sms.git"
#gem "moonshado-sms", :git =>env GIT_SSL_NO_VERIFY=true git clone "https://github.com/moonshado/moonshado-sms.git"

#gem "moonshado", "1.1.0"
#gem "moonshado-sms", "1.1.1.rc1"  #ruby version for windows
#gem "moonshado-sms", "~> 1.1.0"
#gem "moonshado-sms", :git => "git@github.com/moonshado/moonshado-sms.git"
gem 'rails', '3.2.17'
gem "sqlite3-ruby", :require => "sqlite3"

gem "twilio-ruby"

# bundler requires these gems in all environments
# gem "nokogiri", "1.4.2"
# gem "geokit"

group :development do
  # bundler requires these gems in development
  # gem "rails-footnotes"
  #gem "moonshado-sms", "1.1.1.rc1"
  gem "moonshado-sms", :git => "https://github.com/moonshado/moonshado-sms.git" #export GIT_SSL_NO_VERIFY=true (type in console)
  gem "rdoc"
end

group :test do
  # bundler requires these gems while running tests
  # gem "rspec"
  # gem "faker"
end



group :production do
#gem "moonshado-sms", "1.1.0" 
  #gem "moonshado-sms", "1.1.1.rc1"
  gem "moonshado-sms", :git => "https://github.com/moonshado/moonshado-sms.git" #export GIT_SSL_NO_VERIFY=true (type in console)
  gem "rdoc"
end






# A sample Gemfile
#source "http://rubygems.org"





#source :gemcutter


#gem 'sinatra', '1.0'
#gem 'oa-oauth', '0.1.6'
#gem 'dm-sqlite-adapter'




