
require 'rubygems'
require 'twilio-ruby'



desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

######### sms to be sent by daily cron for testing############
  puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}..."
 	  
   current_env=ENV['RAILS_ENV']
    balance=""
    mobilenum=""
    balanceh={}
    reminder_msg=""
    festival_status=""
    
      if current_env=="production"  #used only in production
      
      else
      
      end # if current_env=="production"
    
    
    
    
     send_time=""   
     #send_time=" cron-msg:hemant: "+Time.now.strftime('%d-%m-%Y %H:%M:%S') #msg to be sent
     send_time=Time.now.strftime('%d-%m-%Y %H:%M:%S') #msg to be sent
   

   
   
   
  
   
   @festivals=Festival.find(:all, :order=>"id")
   
   @festivals.each do |f|   
   
     if (f.date.to_date-Time.now.to_date).to_i==0  or (f.date.to_date-Time.now.to_date).to_i==1 or (f.date.to_date-Time.now.to_date).to_i==2 		
     	## if Time.now.strftime("%d-%m-%Y")=="12-10-2011" && date_valid=="Y"
    	##if (f.date.to_date-Time.now.to_date).to_i<3
    	reminder_msg="HONEY I LUV U"
    	reminder_msg=f.message
   		 
   		 
   		 @contacts=Contact.find(:all, :conditions=>"userid=1 and labelnumber=250", :order=>"contactid DESC")
   		 @contacts.each do |con|
   		 mobilenum="+91"+con.labeldetails
   		 
   		 puts "starting sms creation"
   		# balance=reminder_msg
   		 
   		 if mobilenum=="+919899474781"
   		  if current_env=="production"  #used only in production
     	 	 
    	     else
           balance=current_env
          end # if current_env=="production"
       		 
   		 balance=reminder_msg+"-"+balance+send_time
   		 end
   		 
   		  if mobilenum=="+919999652062"
   		 balance=reminder_msg+"-"+"HONEY I LUV U"
   		 end
   		 
   		 
   		 
  	 		puts "done FESTIVAL SMS"
   		end #@contacts.each do |con|
   		 
   		 festival_status==""
   		 
   		else
   		
   		festival_status="NO FESTIVAL"
   		
   		 		
   		
   		end	 #if (f.date.to_date-Time.now.to_date).to_i==0  or (f.date.to_date-Time.now.to_date).to_i==1 		
     			
     					
  	
  	
  	end #@festivals.each do
  	
  	if festival_status=="NO FESTIVAL"
  	  
  	   
  	   
       
		#start TWILIO sms
		puts "start TWILIO"
		 		 @account_sid ='AC0f223cb77a410b35429ca9c3ea11d6b6'
                 @auth_token ='f20006d448513a3639931e286025f25e'
                 # set up a client to talk to the Twilio REST API
                 @client = Twilio::REST::Client.new(@account_sid, @auth_token)
                 @account = @client.account
                 mobilenum="+919999652062"
                 @message = @account.sms.messages.create({:from => '+13058098840', :to =>"+919999652062", :body => balance+":HONEY I LUV U!!! "+mobilenum +send_time})
                 @message	
              puts "Twilio finish +919999652062"    
                # @client = Twilio::REST::Client.new(@account_sid, @auth_token)
                # @account = @client.account
                 mobilenum="+919899474781"
                 @message = @account.sms.messages.create({:from => '+13058098840', :to =>"+919899474781", :body => balance+","+"testing twilio"+send_time+mobilenum})
				 @message
			 puts "Twilio finish +919899474781"
			  @client = Twilio::REST::Client.new(@account_sid, @auth_token)
                 @account = @client.account
                 mobilenum="+919910816234"
                 @message = @account.sms.messages.create({:from => '+13058098840', :to =>"+919910816234", :body => balance+","+"testing twilio"+send_time+mobilenum})
				 @message
			 puts "Twilio finish +919910816234"
			
			mobilenum="+919953951962"
                 @message = @account.sms.messages.create({:from => '+13058098840', :to =>"+919910816234", :body => balance+","+"testing twilio"+send_time+mobilenum})
				 @message
			 puts "Twilio finish +919953951962"
		#end twilio sms
    
    
    
    
    
    
    
  	 puts "done NO FESTIVAL SMS"
  	 	
  	end   ##festival_status if festival_status=="NO FESTIVAL"
  		
end  #task :cron => :environment do

 ##############examples for daily cron:#################

#if ("2011-10-15".to_date-Time.now.to_date).to_i>0      		
     	## if Time.now.strftime("%d-%m-%Y")=="12-10-2011" && date_valid=="Y"
   # 	reminder_msg="HONEY I LUV U"
  # 		 balance=reminder_msg+" "+balance+send_time
   #		 sms=Moonshado::Sms.new("+919999652062","#{balance}") #use this to send reminder to another
   		 
   #	else
  # 		 sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
  # 		 end	







# @msg_cron="good night cron  msg  sent by hemant walia"+Time.now.strftime('%Y/%m/%d %H:%M:%S')
  					# sms=Moonshado::Sms.new("+919899474781", @msg_cron)  
  	               	# sms=Moonshado::Sms.new("#{@mobilenum}","#{@mobilemsg}") 
  	               	 
  			# date_valid="Y" #if date_valid="N" will not go into program		   
  # if Time.now.strftime("%d-%m-%Y")=="09-10-2011" && date_valid=="Y"
    	#reminder_msg="HONEY I LUV U"
   		# balance=reminder_msg+" "+balance+send_time
   		# sms=Moonshado::Sms.new("+919999652062","#{balance}") #use this to send reminder to another
   		# date_valid="N"
   		# else
   		# sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
   		# end
     		
     		
 # if Time.now.hour == 11   #&& Time.now.min==45 
  # User.send_reminders
	## end
	
  #if Time.now.hour % 4 == 0 # run every four hours
   # puts "Updating feed..."
   # NewsFeed.update
  #  puts "done."
 # end

#  if Time.now.hour == 0 # run at midnight
  #if Time.now.hour == 11 # run at afternoon US time and 10.5 hrs ahead in india ie. 9.30 IST

#if (11..23) === Time.now.hour
#puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}..."
  # Run command
#end
############end examples for daily cron:#################
