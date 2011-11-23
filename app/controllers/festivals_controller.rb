class FestivalsController < ApplicationController
#before_filter :authorize 
  
  def index  
    @user_id=params[:uid]||params[:id]
    @festivals= Festival.all(:order => "id")  

            @festival=Festival.new
  
    respond_to do |format|  
         format.html  
       end  
     end  
  
 
  def create 
    @user_id=params[:id]||params[:uid]
      
    festival_array=params[:festival]
    @festival = Festival.create(:name=>festival_array["name"], 
                :date=>festival_array["date"],
                :duration=>festival_array["duration"],
                :message=>festival_array["message"],
                :description=>festival_array["description"],
                :activities=>festival_array["activities"]
                  )
 
    respond_to do |format|  
     if @festival.save  
       format.html { redirect_to(festivals_path ,:id=>params[:id], :uid=>@user_id )}  
          
          format.js
     else  
       flash[:notice] = "Festival failed to save."  
       format.html { redirect_to(festivals_path, :id=>params[:id], :uid=>@user_id) }  
     end  
   end  
   end  
   
  
  def show
    @user_id=params[:uid]||params[:id]
      
    @festivals= Festival.find(params[:id])
      @f=@festivals
           respond_to do |format|  
             format.html  
           end  
    
  end

  def edit
    @user_id=params[:uid]
      @festival = Festival.find(params[:id])
        
    end
  
  def update
      @festival = Festival.find(params[:id])
    @user_id=params[:uid]
      respond_to do |format|
        if @festival.update_attributes(params[:festival])
          flash[:notice] = 'Contact was successfully updated.'
          format.html { redirect_to(@festival, :id=>params[:id], :uid=>@user_id) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit", :id=>params[:id], :uid=>@user_id }
          format.xml  { render :xml => @festival.errors, :status => :unprocessable_entity }
        end
      end
    end
  
  def view
    @user_id=params[:uid]
    @festival = Festival.find(params[:id])
      
    
  end
  
  def delete
      @festival = Festival.find(params[:id])
    @user_id=params[:uid]
        if @festival.nil? or @festival.blank?
          redirect_to :action => 'index', :uid =>@user_id
          
        else
        @festival.destroy
  
      
      respond_to do |format|
        format.html { redirect_to(festivals_url, :uid =>@user_id) }
        format.xml  { head :ok }
      end
       end
      
    end
  
  
    
    def creategreeting
      @user_id=params[:uid]
      @recipient_exist="false"
      _status=""
          
      greetings_array=params[:greetings]
        @member_id=greetings_array["1"]
        @festival_id=greetings_array["2"]
         @people=greetings_array["3"] 
          
          if @member_id.nil? or @festival_id.nil?
                     
            _status="FAIL"
          else
          _status="PASS"
          
        ######### sms to be sent -greeting############
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
           
             if f.id==@festival_id.to_i
            # if (f.date.to_date-Time.now.to_date).to_i==0  or (f.date.to_date-Time.now.to_date).to_i==1 or (f.date.to_date-Time.now.to_date).to_i==2    
              ## if Time.now.strftime("%d-%m-%Y")=="12-10-2011" && date_valid=="Y"
              ##if (f.date.to_date-Time.now.to_date).to_i<3
              reminder_msg="HONEY I LUV U"
              reminder_msg=f.message
               
               
               @contacts=Contact.find(:all, :conditions=>"userid=#{@member_id.to_i} and labelnumber=250", :order=>"contactid DESC")
              
               @contacts.each do |con|
                
                 if @people=="ALL"
                 @recipient_record=Contact.find(:first, :conditions=>"labelnumber=150 and contactid=#{con.contactid}")
                 else
                 @recipient_record=Contact.find(:first, :conditions=>"labelnumber=150 and labeldetails LIKE '#{@people}' and contactid=#{con.contactid}")
                 end
                 
                 
                 if @recipient_record.nil? or @recipient_record.blank?
                                                    
                 else
                 
                   @recipient_exist="true"  
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
             
                 end #  if @recipient_record.nil? or @recipient_record.blank?
                 end #@contacts.each do |con|
               
              else
               sms=Moonshado::Sms.new("+919899474781","#{balance}") #this for daily testing
              puts "starting sms delivery" 
             sms.deliver_sms  ####this is main one used to send the sms 
             puts "done"
              
              
              end  #if (f.date.to_date-Time.now.to_date).to_i==0  or (f.date.to_date-Time.now.to_date).to_i==1    
                  
             #########END sms to be sent -greeting############              
            
            
            end #@festivals.each do     
          
          end    #if @memberid.nil? or @festival_id.nil?

#redirect_to :action=>index, :uid=>@user_id
              
    @status=_status
  
end




end #FINAL