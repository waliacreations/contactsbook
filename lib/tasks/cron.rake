desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  #if Time.now.hour % 4 == 0 # run every four hours
   # puts "Updating feed..."
   # NewsFeed.update
  #  puts "done."
 # end

#  if Time.now.hour == 0 # run at midnight
  if Time.now.hour == 11 # run at afternoon US time and 10.5 hrs ahead in india ie. 9.30 IST
   sms=Moonshado::Sms.new("+919899474781", "good night cron  msg  sent by hemant walia")  
    # sms=Moonshado::Sms.new("#{@mobilenum}","#{@mobilemsg}")     
    sms.deliver_sms
   
   # User.send_reminders
  end
end