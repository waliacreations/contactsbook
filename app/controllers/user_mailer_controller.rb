


class UserMailerController < ActionController::Base
  
  
  
  def index
    
    
  end
  
  def reply
     @title = "Reply"
     @sender = ''
     @subject = ''
     @message = ''
   end
 
   
  
   

  def sendmail
    # email = params[:email]
     recipient = params["recipient"]
   # recipient="waliacreations@yahoo.com"
     subject = params["subject"]
      # subject="TEST"
     message = params["message"]
    #   message="TEST"
       UserMailer.deliver_reply(recipient, subject, message)
       return if request.xhr?
       render :text => 'Message sent successfully'
    end
   
   def sendmailold
     @sender = params[:sender]
     @subject = params[:subject]
     @message = params[:message]
     if validate(@sender, @subject, @message)
       UserMailer.deliver_reply(@sender, @subject, @message)
          # return if request.xhr?
           render :text => 'Message sent successfully'
           
    #   user_mailer.reply(@sender, @subject, @message).deliver      
       flash[:success] = "Message sent successfully"      
       redirect_to :action=>"reply"
     else
       flash.now[:error] = @error     
       render :action=>'reply'
     end
   end
 
   private
     def validate(sender, subject, message)
       @email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
       if sender.blank? || subject.blank? || message.blank?
         @error = "Message not sent: Required information not filled"
         return false
       elsif subject.length >= 50
         @error = "Message not sent: Subject must be smaller than 50 characters"
         return false
     elsif sender[@email_regex].nil?
         @error = "Message not sent: Email not valid"
         return false
       else
         return true
       end
     end
   
  
end
