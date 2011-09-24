


class UserMailerController < ActionController::Base
  
  
  
  def index
    
    
  end
  
  def reply
     @title = "Reply"
     @sender||= ''
     @subject||= ''
     @message ||= ''
   end
 
   
  
   

  def sendmail
     email_array = params[:email]
    item1=[]
       item2=[]
       item3=[]
       item4=[]
         to_create1=params[:email]
   # if to_create1
          
         # to_create1.each do |key, value|
         # x= key.to_s
          #flash['notice'] =x
       #   item1[x.to_s]=value
          
        #  end
  #end
       
    recipient = email_array["recipient"]
   # recipient="waliacreations@yahoo.com"
     subject = email_array["subject"]
      # subject="TEST"
    message = email_array["message"]
       #message="TEST"
       UserMailer.deliver_reply(recipient, subject, message)
       return if request.xhr?
       render :text => 'Message sent successfully'+subject+recipient+message
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
