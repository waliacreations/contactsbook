
desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

######### sms to be sent by daily cron for testing############
  	 puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}..."
 	 
  
   current_env=ENV['RAILS_ENV']
    balance=""
    mobilenum=""
    balanceh={}
    reminder_msg=""
    
      if current_env=="production"  #used only in production
      balanceh=Moonshado::Sms.get_credit #Moonshado::Sms.get_credit
      balance=balanceh.collect { |k, v| "[balance='#{k}'#{v}]" }.join  #get balance credit in moonshado
      else
      balance=current_env
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
     	 	 balanceh=Moonshado::Sms.get_credit #Moonshado::Sms.get_credit
     		 balance=balanceh.collect { |k, v| "[balance='#{k}'#{v}]" }.join  #get balance credit in moonshado
    	     else
           balance=current_env
          end # if current_env=="production"
       		 
   		 balance=reminder_msg+"-"+balance+send_time
   		 end
   		 
   		  if mobilenum=="+919999652062"
   		 balance=reminder_msg+"-"+"HONEY I LUV U"
   		 end
   		 
   		 
   		 #sms=Moonshado::Sms.new("+919999652062","#{balance}") #use this to send reminder to another
   		 sms=Moonshado::Sms.new("#{mobilenum}","#{balance}") #use this to send reminder to another
   		 puts "starting sms delivery" 
     		sms.deliver_sms  ####this is main one used to send the sms 
  	 		puts "done"
   		end #@contacts.each do |con|
   		 
   		else
   		 sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
   		puts "starting sms delivery" 
     sms.deliver_sms  ####this is main one used to send the sms 
  	 puts "done"
   		
   		
   		end	 #if (f.date.to_date-Time.now.to_date).to_i==0  or (f.date.to_date-Time.now.to_date).to_i==1 		
     			
     					
  	
  	
  	end #@festivals.each do
  		
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
