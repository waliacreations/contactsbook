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
       format.html { redirect_to festivals_path }  
       format.js  
     else  
       flash[:notice] = "Festival failed to save."  
       format.html { redirect_to festivals_path }  
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
  
  
  
  
  
  
  
end