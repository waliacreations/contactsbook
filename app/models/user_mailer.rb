class UserMailer < ActionMailer::Base
 # default :to => "admin@icontacts.com"
  
  
  #def welcome_email(user)
     # recipients    user.email
    #  from          "My Awesome Site Notifications <notifications@example.com>"
    #  subject       "Welcome to My Awesome Site"
     # sent_on       Time.now
      #body          {:user => user, :url => "http://example.com/login"}
    #body          :user => user, :url => "http://example.com/login"
   # end
  
  
  #http://molblog.heroku.com/2011/04/17/18-contact-me-form-rails-mailer-setup-  

    
  def reply(recipient, subject, message, sent_at = Time.now)
        @subject = subject
        @recipients = recipient
        @from = 'admin@icontactsbook.com'
        @sent_on = sent_at
      @body["title"] = 'This is title'
        @body["email"] = 'waliacreations@yahoo.com'
        @body["message"] = message
        @headers = {}
     end   
    
  def letter(recipient, subject, message, sent_at = Time.now)
        @subject = subject
        @recipients = recipient
        @from = 'admin@icontactsbook.com'
        @sent_on = sent_at
      @body["title"] = 'This is title'
        @body["email"] = 'waliacreations@yahoo.com'
        @body["message"] = message
        @headers = {}
     end     
    
end
