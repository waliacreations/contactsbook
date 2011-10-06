


desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  #if Time.now.hour % 4 == 0 # run every four hours
   # puts "Updating feed..."
   # NewsFeed.update
  #  puts "done."
 # end

#  if Time.now.hour == 0 # run at midnight
  #if Time.now.hour == 11 # run at afternoon US time and 10.5 hrs ahead in india ie. 9.30 IST
 
 
 # if Time.now.hour == 6   #&& Time.now.min==45
   puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}..."
  puts "starting sms creation"
   sms=Moonshado::Sms.new("+919899474781", "good night cron  msg  sent by hemant walia")  
    # sms=Moonshado::Sms.new("#{@mobilenum}","#{@mobilemsg}")     
   puts "starting sms delivery" 
    sms.deliver_sms
   puts "done"
   # User.send_reminders
# end
end