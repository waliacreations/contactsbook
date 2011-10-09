
desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

######### sms to be sent by daily cron for testing############
  	 puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}..."
 	 puts "starting sms creation"
  
   current_env=ENV['RAILS_ENV']
    balance=""
    balanceh={}
    reminder_msg=""
    
      if current_env=="production"  #used only in production
      balanceh=Moonshado::Sms.get_credit #Moonshado::Sms.get_credit
      balance=balanceh.collect { |k, v| "[balance='#{k}'#{v}]" }.join  #get balance credit in moonshado
      else
      balance=current_env
      end
      
     send_time=""   
     send_time=" cron-msg:hemant: "+Time.now.strftime('%d-%m-%Y %H:%M:%S') #msg to be sent
     
        if Time.now.strftime("%d-%m-%Y")=="09-10-2011" 
    	reminder_msg="HONEY I LUV U"
   		 balance=reminder_msg+" "+balance+send_time
   		 sms=Moonshado::Sms.new("+9199652062","#{balance}") #use this to send reminder to another
   		 else
   		 sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
   		 end
     				
     	 if Time.now.strftime("%d-%m-%Y")=="10-10-2011" 
    	reminder_msg="HONEY I LUV U"
   		 balance=reminder_msg+" "+balance+send_time
   		 sms=Moonshado::Sms.new("+9199652062","#{balance}") #use this to send reminder to another
   		 else
   		 sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
   		 end			
     				
     	 if Time.now.strftime("%d-%m-%Y")=="11-10-2011" 
    	reminder_msg="HONEY I LUV U"
   		 balance=reminder_msg+" "+balance+send_time
   		 sms=Moonshado::Sms.new("+9199652062","#{balance}") #use this to send reminder to another
   		 else
   		 sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
   		 end		
     		
     	 if Time.now.strftime("%d-%m-%Y")=="12-10-2011" 
    	reminder_msg="HONEY I LUV U"
   		 balance=reminder_msg+" "+balance+send_time
   		 sms=Moonshado::Sms.new("+9199652062","#{balance}") #use this to send reminder to another
   		 else
   		 sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
   		 end	
     			
     					
  	 puts "starting sms delivery" 
     sms.deliver_sms  ####this is main one used to send the sms 
  	 puts "done"
  		
end  #task :cron => :environment do




 ##############examples for daily cron:#################
# @msg_cron="good night cron  msg  sent by hemant walia"+Time.now.strftime('%Y/%m/%d %H:%M:%S')
  					# sms=Moonshado::Sms.new("+919899474781", @msg_cron)  
  					# sms=Moonshado::Sms.new("#{@mobilenum}","#{@mobilemsg}")     

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
