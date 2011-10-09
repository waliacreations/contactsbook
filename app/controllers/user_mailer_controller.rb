-


#class UserMailerController < ActionController::Base
 
class UserMailerController <ApplicationController
before_filter :authorize 
  
  
  def index
    @user_id=0
          @user_id=params[:uid]
            if @user_id.nil?
              if params[:id].nil?
              @user_id=0
              else
              @user_id=params[:id]
              end #if params[:id].nil?
            end #if user_id.nil?
            
    
  end
  
  def reply
     @title||= "Reply"
     @sender||= ''
     @subject||= ''
     @message ||= ''
   end
 
   
  
   

  def sendmail
    
    
    
      if params[:mobilenum].nil?
      @mobile="+919899474781"
      else
      @mobile=params[:mobilenum]
      end
          
    @user_id=0
          @user_id=params[:uid]
            if @user_id.nil?
              if params[:id].nil?
              @user_id=0
              else
              @user_id=params[:id]
              end #if params[:id].nil?
            end #if user_id.nil?
            
     email_array = params[:email]
     item1=[]
       item2=[]
       item3=[]
       item4=[]
         to_create1=params[:email]
                 
    recipient = email_array["recipient"]
   # recipient="waliacreations@yahoo.com"
     subject = email_array["subject"]
     # subject="TEST"
     
    @mobilenum=email_array["mobile"]
        
    if @mobilenum.nil?
         @mobilenum="+919899474781"
     end   
      
    message = email_array["message"]
    @mobilemsg= email_array["message"] 
      
       #message="TEST"
       UserMailer.deliver_reply(recipient, subject, message)
      return if request.xhr?
      
      ### to send sms from moonshado sms addon 
    #sms=Moonshado::Sms.new("+919899474781", "test  msg  sent by hemant walia")  
   # current_env="#{RAILS_ENV}"
    #current_env="#{ENV['RAILS_ENV']}"
    current_env=ENV['RAILS_ENV']
    balance=""
    balanceh={}
      if current_env=="production"
      balanceh=Moonshado::Sms.get_credit
        balance=balanceh.collect { |k, v| "[balance='#{k}'#{v}]" }.join
    else
      balance=current_env
      
    end
      sms=Moonshado::Sms.new("#{@mobilenum}","#{@mobilemsg+balance}")     
    sms.deliver_sms
    #Moonshado::Sms.get_credit
   
       redirect_to :controller=>'user_mailer', :action=>'show', :id=>params[:id], :uid=>params[:uid],
         :email=>'Message sent successfully. '+" TO: "+recipient+" Subject: "+subject+" Message: "+message+balance
       #render :text => 'Message sent successfully'+subject+recipient+message
    end
   
    
    def show
      @user_id=0
       @user_id=params[:uid]
         if @user_id.nil?
           if params[:id].nil?
           @user_id=0
           else
           @user_id=params[:id]
           end #if params[:id].nil?
         end #if user_id.nil?
         
       @status=params[:email]
             if @status.nil?
               @status="First Mail"
             end
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
