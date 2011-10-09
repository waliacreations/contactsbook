


desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  #if Time.now.hour % 4 == 0 # run every four hours
   # puts "Updating feed..."
   # NewsFeed.update
  #  puts "done."
 # end

#  if Time.now.hour == 0 # run at midnight
  #if Time.now.hour == 11 # run at afternoon US time and 10.5 hrs ahead in india ie. 9.30 IST

if (11..23) === Time.now.hour
puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}..."
  # Run command
end

 ## if Time.now.hour == 11   #&& Time.now.min==45
   puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}..."
  puts "starting sms creation"
  
   current_env=ENV['RAILS_ENV']
    balance=""
    balanceh={}
      if current_env=="production"
      balanceh=Moonshado::Sms.get_credit
        balance=balanceh.collect { |k, v| "[balance='#{k}'#{v}]" }.join
    else
      balance=current_env
      
    end
    
    balance+="cron  msg hemant walia"+Time.now.strftime('%Y/%m/%d %H:%M:%S')
      
      sms=Moonshado::Sms.new("+919899474781","#{balance}")     
    
  
  
 # @msg_cron="good night cron  msg  sent by hemant walia"+Time.now.strftime('%Y/%m/%d %H:%M:%S')
  # sms=Moonshado::Sms.new("+919899474781", @msg_cron)  
    # sms=Moonshado::Sms.new("#{@mobilenum}","#{@mobilemsg}")     
   puts "starting sms delivery" 
    sms.deliver_sms
   puts "done"
   # User.send_reminders
## end
end

#Moonshado::Sms.get_credit
