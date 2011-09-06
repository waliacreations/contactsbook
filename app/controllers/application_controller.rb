# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

 # cookies[:walia]={:value=>"hello", :expires=>Time.now + 12.hours}
  ## session :off  turns off session for whole application
  
  #ActionController::Base.session_options[:expire_after] = 3.years
 # session :session_key=> "_my_session_id"
  
  private
    def authorize               # to make sure current session has been registered
      if session[:username].nil?
      #unless Login.find_by_username(session[:username])
      flash[:notice]="Please Log IN:"
      #redirect_to(:controller=>"home", :action=>"index", :msg=>"PLEASE LOG IN")
      
      @msg_login="PLEASE LOG IN"
      
      redirect_to(:controller=>"home",:action=>"index", :msg=>"PLEASE LOG IN")
      end
     end #authorize
  
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
