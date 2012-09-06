class TransactionsController <ApplicationController
before_filter :authorize 
  
  ### to capture sms received when sent to 69940 from US number with keyword:"icontactsbook"
  ####posted by moonshado to "http://www.icontactsbook.com/sms/create"
  
 # def index
 #  @user_id=1
 #   @user_id=params[:uid]
 #    if @user_id.nil?
  #   if params[:id].nil?
  #    @user_id=0
  #    else
  #    @user_id=params[:id]
  #    end #if params[:id].nil?
  # end #if user_id.nil?
 #end
  
 
  def index  
    redirect_to :controller=>'contacts', :action => 'viewsummary' 
   # @user_id=params[:uid]||params[:id]
       #@messages= Message.all(:order => "created_at DESC")  
       #respond_to do |format|  
        # format.html  
       #end  
     end  
  
  
  def create 
  # @message = Message.create(:device_address => params["device_address"], :country=>"IN", :shortcode=>params["shortcode"], :carrier=>params["carrier"], :message=>params["message"])  
  # respond_to do |format|  
    # if @message.save  
      # format.html { redirect_to messages_path }  
      # format.js  
     #else  
    #   flash[:notice] = "Message failed to save."  
     #  format.html { redirect_to messages_path }  
    # end  
   #end  
    end  
   
  
  def show
   # @messages= Message.all(:order => "id DESC")  
          # respond_to do |format|  
            # format.html  
            # format.js  
        #  end  
    
  end

 
  def send
   # @messages= Message.all(:order => "id DESC")  
         #   respond_to do |format|  
           #   format.html  
          #    format.js  
          #  end  
     
   end

  
  
  
  
end