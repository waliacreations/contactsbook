class ContactsController < ApplicationController
 #before_filter :cookies_required, :except => ["cookies_test"]
  
  #validates_format_of :name, :with => /\A[\w\.\-\+]+\z/  
  #consist only of alphanumeric characters, dots, + and -
  
  before_filter :authorize 
  
  # GET /contacts
  # GET /contacts.xml
 
   def index
    redirect_to :action => 'viewsummary'    
  #  @contacts = Contact.all

   # respond_to do |format|
   #   format.html # index.html.erb
   #   format.xml  { render :xml => @contacts }
   # end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
 
  
  
  def say_hello
   render(:layout=>false) 
  end
  
  
  def show_address
    @choice=params[:choice]
    render(:layout=>false) 
   # render(:partial=>'address')
  end
  
  def hide_address
     @choice=params[:choice]
     render(:layout=>false) 
    # render(:partial=>'address')
   end
  
  def show_spouse
     @choice=params[:choice]
     render(:layout=>false) 
    # render(:partial=>'address')
   end
   
   def hide_spouse
      @choice=params[:choice]
      render(:layout=>false) 
     # render(:partial=>'address')
    end  
   
  def show_kids
     @choice=params[:choice]
     render(:layout=>false) 
    # render(:partial=>'address')
   end
   
   def hide_kids
      @choice=params[:choice]
      render(:layout=>false) 
     # render(:partial=>'address')
    end
   
   
   
   
  def show_memo
    @choice=params[:choice]
    render(:layout=>false) 
   # render(:partial=>'address')
  end
  
  def hide_memo
     @choice=params[:choice]
     render(:layout=>false) 
    # render(:partial=>'address')
   end
   
   
   
   
   
   
   
  def show
    if params[:id]=="viewsummary"
       @contact=Contact.find(:all, :conditions=>"labelnumber=152")
    else
      @cid=params[:id]
    @contact=Contact.find(@cid)
   
    end  
    
     respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
    
  end

  # GET /contacts/new
  # GET /contacts/new.xml
 
  def append
  #first populate records with existing info and then let user edit/add new info
   #@order_pages, @orders = paginate :orders, :per_page => 30
      listid=1
      listid=params[:id]
   
      if listid.nil?
        redirect_to(:action=> 'viewsummary')
  
        flash.now['notice'] = "NO ID chosen"
       
    else
   # @contact=Contact.new  
    #@contacts=Contact.find(:all)
    @contactlist=Contact.find(:all, 
        :conditions=>"contactid=#{listid}",
        :order=>["labelnumber"])
    @con=Contact.find(:first, :conditions=>"contactid=#{listid}")
    @c=@con.contactid
    @labels=Label.find(:all)
    end 
  
    end
  
  
  def appendmultiple
    @user_id=params[:uid]
    @billdate3=params[:bill_date]
    @billdate2=@billdate3.to_date
    @billdate1=@billdate2.strftime("%d-%m-%Y")
    @billdate=@billdate1+" 00:00:00"
   
    @pwd=params[:pwd_key]
    
    if @pwd=="WALIA" or @pwd=="walia" 
    
    #@c=params[:id]
    cid=params[:id]
    conid=params[:contact_new]
    if conid.nil? or conid==""
    conid=15
    end
    status="YES"
    
    @contacts=Contact.find(:all)
    @labels=Label.find(:all)
     new_contact=Contact.new
    @contact=Contact.new
    #@contact=Contact.create(params)   #:labeldetails,:contactid,:time_at])
    x=0
    
    item1=[]
    item2=[]
    item3=[]
    item4=[]
    to_create1=params[:labelnumber]
    to_create2=params[:labeldetails]
    to_create3=params[:contactid]
    to_create4=params[:created_at]
    if to_create1
      
      to_create1.each do |key, value|
      x= key.to_f
      flash['notice'] =x
      item1[x]=value
      
      end
    end
      if to_create2
      to_create2.each do |key, value|
      x=key.to_f
      item2[x]=value
    end
    end
      if to_create3
      to_create3.each do |key, value|
      x=key.to_f
      item3[x]=value
      
    end
    end
      if to_create4
      to_create4.each do |key, value|
      x=key.to_f
      item4[x]=value
    end
    end
  
  
  
    #item1<<params[:labelnumber]
    
    x=1
    y=1
      
    if item1[x].nil?     
        render :action => 'new'
         flash.now['notice'] = 'Contact was not created.'
        else
       cid=item3[x]
    if cid.nil?
      else
       @deletions=Contact.find(:all, :conditions=>"contactid='#{cid}'")
      
      @deletions.each do|@deletion|
        
      @deletion.destroy
    end   
    end   
          
          
        item1.each do
      if item2[x].nil? or item2[x]==""
        x=x+1
      else
        @contact= Contact.create(
          :labelnumber=>item1[x],
        :labeldetails=>item2[x],
        :contactid=>item3[x],
        :created_at=>item4[x],
        :userid=>@user_id
        )
          @contact.save!
          x=x+1
          y=y+1
        end
        end
         #flash.now[:notice] = 'Contact was successfully created.'
        redirect_to :action => 'view', :id => @contact.contactid
  end 
  
  @time1=Time.now.strftime("%d-%m-%Y %H:%M:%S")
      
       @invoicedate=Contact.find(:first, :conditions=>"labelnumber=156 and contactid=#{cid}")    
        #@amount=Contact.find(:first, :conditions=>"labelnumber=12900 and ordervoucherid=#{cid}")
       if @invoicedate.nil?
          @DeleteInvoice=DeleteInvoice.create(
          :date=>@time1,
          #:date=>@time1,
        :amount=>0,
        :formid=>cid,
        :formtype=>'contactappend',
        :time_at=>@time1
        )
          @DeleteInvoice.save! 
         
         
      else
           @DeleteInvoice=DeleteInvoice.create(
          :date=>@invoicedate.labeldetails,
          #:date=>@time1,
        :amount=>0,
        :formid=>cid,
        :formtype=>'contactappend',
        :time_at=>@time1
        )
          @DeleteInvoice.save! 
         
      end         
        
  
    end #pwdkey
  end #def appendmultiple 
  
  
  def validateemail
    @phrase1=[]
    @phrase2=[]
      msg=""
      msg1=""
      msg2=""
      msg3=""
      msg4=""
      msg5=""
      msg6=""
      msg7=""
      msgbeg=""
      msgbeg1=""
      
    @results1=""
    @results2=""
    @results3=""
    @emailbegin=[]
    @emailend=[]
    @phrase1=params[:labeldetails_9]
      
 if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<9
   msgbeg="ENTER EMAIL!!!"
   msg+=msgbeg
  else    
     msgbeg="ok" 
    @phrase2=@phrase1.split("@")
    
    if @phrase2[1]=="" or @phrase2[1].nil?
   msgbeg1="NO '@'CHECK EMAIL!!!"
   msg+=msgbeg1
    else 
    msgbeg1="ok"
    @emailend=@phrase2[1].split(".")
    
    
    
if @emailend[1].nil? or @emailend[1]==""
  msg+="check email address after '.' :"
  @results1=""
else
     msg1="ok" 
  @results2="."+@emailend[1]
end
   
if @emailend[2].nil? or @emailend[2]==""
  msg2="ok"
else
     msg2="ok"   
      @results2+="."+@emailend[2]
end

if @emailend[3].nil? or @emailend[3]=="" ##ie..com.com.com
  msg3="ok"
else
     msg+="extra . or words in email:"
      @results1="" 
 end 
 
 case @emailend[0].downcase  ##this is after @sign
when "yahoo"
  msg4="ok"
 #@results1="ok"
 
when "gmail"
msg4="ok"
#@results1="ok"
   
when "hotmail"  
msg4="ok"
#@results1="ok" 
 
when "walianet"  
msg4="ok"
#@results1="ok" 
 
when "rediff"
msg4="ok"
#@results1="ok" 

when "google"
msg4="ok"
#@results1="ok" 

else 
msg4="PLEASE GIVE yahoo,gmail,google,hotmail,walianet EMAIL!!!"  
msg+=msg4
@results1=""
end
  
case @results2.downcase  ##this is after @sign+. ie..com/.co.in/.info
when ".co.in"
  msg5="ok"
 #@results1="ok"
 
when ".com"
msg5="ok"
#@results1="ok"
   
else 
msg5="PLEASE GIVE '.co.in' or '.com' EMAIL!!!" 
msg+=msg5 
@results1=""
end


 if @phrase2[0].to_i>0 #if digits before @ is a number 
  msg6="ONLY Number before '@' Check email: "
  msg+=msg6
  @results1=""
else
  msg6="ok"
end  
  
if @phrase2[0].nil? or @phrase2[0].to_s=="" #if digits before @ is a number 
  msg7="number only before '@' check email: "
  @results1=""
  msg+=msg7
else
  msg7="ok"
end  

 end  #if @phrase2[1]=="" or @phrase2[1].nil?  
 
  end # if @phrase1=="" or @phrase1.nil?
  
    respond_to do |format|
      
        format.js {
        render :update do |page|
         
           _msg=msg
     
           if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
            page.alert("Email Validation:"+_msg)
            @results1=""
            page['labeldetails_9'].value=@results1
            page['labeldetails_9'].focus()  
            else
              _msg="OK"
              
              page.alert("Email Validation:"+_msg) 
            end 
         
           end #render :update do |page|
              }
          end #respond_to do |format|
  
   end #validateemail
 
   
   
    
def validatewebsite1
   @phrase1=[]
   @phrase2=[]
     msg=""
     msg1=""
     msg2=""
     msg3=""
     msg4=""
     msg5=""
     msg6=""
     msg7=""
     msgbeg=""
     msgbeg1=""
   @results1=""
   @results2=""
   @results3=""
   @emailbegin=[]
   @emailend=[]
   @phrase1=params[:labeldetails_15]
   
   
  if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<7
     msgbeg="ENTER Website1!!!"
     msg+=msgbeg
    else    
       msgbeg="ok" 
      @phrase2=@phrase1.split("/")
      
      if @phrase2=="" or @phrase2.nil?
     msgbeg1="CHECK WEBSITE1!!!"
     msg+=msgbeg1
      else 
        msgbeg1="ok"
        @emailend=@phrase2[0].split(".")   
   
if @emailend[0].to_s=="www"   
   msgbeg="ok"
else
   msgbeg="start with www: website1"
   msg+=msgbeg
   @results1=""
end
if @emailend[1].nil? or @emailend[1]==""
  msg1="check web address :Incomplete Website1"
 msg+=msg1
 @results1=""
else
    msg1="check web address :Incomplete Website1" 
    msg+=msg1
    msg1="ok"
    @results1=""
# @results2="."+@emailend[1]
 dotlast=""
end
  
if @emailend[2].nil? or @emailend[2]==""
 msg2="ok"
else
    msg2="ok" 
    msg=""   # to remove above comment of  incomplete
   # msg+=msg2  
     @results2="."+@emailend[2]
     dotlast=@emailend[2]
end

if @emailend[3].nil? or @emailend[3]=="" ##ie..com.com.com
 msg3="ok"
else
    msg3="ok"
    #msg+=msg3
    @results2+="."+@emailend[3]
    dotlast=@emailend[3]
     @results1="" 
end 

if @emailend[4].nil? or @emailend[4]=="" ##ie..com.com.com
 msg4="ok"
else
    msg4="extra . or words in website1:"
    msg+=msg4
     @results1="" 
end 


 
case @results2.downcase  ##this is after @sign+. ie..com/.co.in/.info
when ".co.in"
 msg5="ok"
#@results1="ok"

when ".com"
msg5="ok"
#@results1="ok"
  
  when ".heroku.com"
  msg5="ok"
  #@results1="ok"

when ".in"
msg5="ok"

else 
msg5="PLEASE GIVE '.co.in' or '.com' or '.in' WEBSITE1!!!" 
msg+=msg5 
@results1=""
end


if @phrase2[0].length<1 #if digits before @ is a number 
 msg6="Check web address1: "
 msg+=msg6
 @results1=""
else
 msg6="ok"
end  
 
if @phrase2[0].nil? or @phrase2[0].to_s=="" #if digits before @ is a number 
 msg7="Check website1 address: "
 @results1=""
 msg+=msg7
else
 msg7="ok"
end  
   
end  #if @phrase2.nil? or @phrase2==""

end   #if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<7

   respond_to do |format|
     
       format.js {
       render :update do |page|
        
          _msg=msg
    
        # page.alert(@emailend[length].downcase)
          
          if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
           page.alert("Website1 Validation:"+_msg)
           @results1=""
           page['labeldetails_15'].value=@results1
           page['labeldetails_15'].focus()  
           else
             _msg="OK"
             page.alert("Website1 Validation:"+_msg) 
           end 
        
          end #render :update do |page|
             }
         end #respond_to do |format|
         
  end #validatwebsite1
  
   
def validatewebsite2
   @phrase1=[]
   @phrase2=[]
     msg=""
     msg1=""
     msg2=""
     msg3=""
     msg4=""
     msg5=""
     msg6=""
     msg7=""
     msgbeg=""
     msgbeg1=""
   @results1=""
   @results2=""
   @results3=""
   @emailbegin=[]
   @emailend=[]
   @phrase1=params[:labeldetails_16]
   
   
  if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<7
     msgbeg="ENTER Website2!!!"
     msg+=msgbeg
    else    
       msgbeg="ok" 
      @phrase2=@phrase1.split("/")
      
      if @phrase2=="" or @phrase2.nil?
     msgbeg1="CHECK WEBSITE2!!!"
     msg+=msgbeg1
      else 
        msgbeg1="ok"
        @emailend=@phrase2[0].split(".")   
   
if @emailend[0].to_s=="www"   
   msgbeg="ok"
else
   msgbeg="start with www: website2"
   msg+=msgbeg
   @results1=""
end
if @emailend[1].nil? or @emailend[1]==""
  msg1="check web address2 :Incomplete Website2"
 msg+=msg1
 @results1=""
else
    msg1="check web address2 :Incomplete Website2" 
    msg+=msg1
    msg1="ok"
    @results1=""
# @results2="."+@emailend[1]
 dotlast=""
end
  
if @emailend[2].nil? or @emailend[2]==""
 msg2="ok"
else
    msg2="ok" 
    #msg=""   # to remove above comment of  incomplete
   # msg+=msg2  
     @results2="."+@emailend[2]
     dotlast=@emailend[2]
end

if @emailend[3].nil? or @emailend[3]=="" ##ie..com.com.com
 msg3="ok"
else
    msg3="ok"
    #msg+=msg3
    @results2+="."+@emailend[3]
    dotlast=@emailend[3]
     @results1="" 
end 

if @emailend[4].nil? or @emailend[4]=="" ##ie..com.com.com
 msg4="ok"
else
    msg4="extra . or words in email:"
    msg+=msg4
     @results1="" 
end 


 
case @results2.downcase  ##this is after @sign+. ie..com/.co.in/.info
when ".co.in"
 msg5="ok"
#@results1="ok"

when ".com"
msg5="ok"
#@results1="ok"
 
  when ".heroku.com"
  msg5="ok"
  #@results1="ok"
 
when ".in"
msg5="ok"

else 
msg5="PLEASE GIVE '.co.in' or '.com' or '.in' WEBSITE2!!!" 
msg+=msg5 
@results1=""
end


if @phrase2[0].length<1 #if digits before @ is a number 
 msg6="Check web address2: "
 msg+=msg6
 @results1=""
else
 msg6="ok"
end  
 
if @phrase2[0].nil? or @phrase2[0].to_s=="" #if digits before @ is a number 
 msg7="Check website2 address: "
 @results1=""
 msg+=msg7
else
 msg7="ok"
end  
   
end  #if @phrase2.nil? or @phrase2==""

end   #if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<7

   respond_to do |format|
     
       format.js {
       render :update do |page|
        
          _msg=msg
    
        # page.alert(@emailend[length].downcase)
          
          if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
           page.alert("Website2 Validation:"+_msg)
           @results1=""
           page['labeldetails_16'].value=@results1
           page['labeldetails_16'].focus()  
           else
             _msg="OK"
             page.alert("Website2 Validation:"+_msg) 
           end 
        
          end #render :update do |page|
             }
         end #respond_to do |format|
         
  end #validatwebsite2
  
     
   
   
   
   
   
   
   
   
   
 def quickentry
   @username=session[:username]
  @user_id=params[:id]
  @choice=params[:choice]
    if @choice.nil?
      @choice="none"
    end
  @contact=Contact.find(:last)
 end
  
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

 
  
  
def createmultiple
	@user_id=params[:uid] #user_id
	cid=params[:id]
	if cid.nil?
		else
	   @deletions=Contact.find(:all, :conditions=>"contactid='#{cid}'")
	  
	  @deletions.each do|@deletion|
		  
		@deletion.destroy
	end   
	end
	 #flash['notice'] = 'Contact was successfully created.'
	@contacts=Contact.find(:all)
	@labels=Label.find(:all)
	 new_contact=Contact.new
	@contact=Contact.new
	#@contact=Contact.create(params)	 #:labeldetails,:contactid,:time_at])
	x=0
	
	item1=[]
	item2=[]
	item3=[]
	item4=[]
	to_create1=params[:labelnumber]
	to_create2=params[:labeldetails]
	to_create3=params[:contactid]
	to_create4=params[:created_at]
	if to_create1
		
		to_create1.each do |key, value|
		x= key.to_f
		flash['notice'] =x
		item1[x]=value
		
		end
	end
		if to_create2
		to_create2.each do |key, value|
		x=key.to_f
		item2[x]=value
	end
	end
		if to_create3
		to_create3.each do |key, value|
		x=key.to_f
		item3[x]=value
		
	end
	end
		if to_create4
		to_create4.each do |key, value|
		x=key.to_f
		item4[x]=value
	end
	end



	#item1<<params[:labelnumber]
	
	x=1
	y=1
		
	if item1[x].nil?     
      render :action => 'new'
       flash.now['notice'] = 'Contact was not created.'
      else
	   cid=item3[x]
	if cid.nil?
		else
	   @deletions=Contact.find(:all, :conditions=>"contactid='#{cid}'")
	  
	  @deletions.each do|@deletion|
		  
		@deletion.destroy
	end   
	end   
	      
	      
      item1.each do
		if item2[x].nil? or item2[x]==""
			x=x+1
		else
	    @contact= Contact.create(
	    :labelnumber=>item1[x],
		  :labeldetails=>item2[x],
		  :contactid=>item3[x],
		  :created_at=>item4[x],
		  :userid=>@user_id
		  )
	      @contact.save!
	      x=x+1
	      y=y+1
      end
      end
       #flash.now[:notice] = 'Contact was successfully created.'
      redirect_to :action => 'view', :id => @contact.contactid, :uid=>@user_id
end
end


def validatecategory_1
   @phrase1=[]
       @phrase2=[]
         @msg=""
         msg1="" 
         msgbeg=""
         @sel=[]  #select_tag
        @phrase1=params[:Tlabeldetails_1] 
           
   if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<3 or @phrase1.size>15
     msgbeg="CHOOSE TITLE!!!"
     @msg=msgbeg
     
    else    
       msgbeg="ok" 
       @msg="ok"
   end   
   respond_to do |format|
      
       
         format.js {              
         render :update do |page|            
            _msg=@msg
      
            #if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
           if msgbeg!="ok"                             
           # page.alert("Title Validation:"+_msg)
           # end 
            @results1="Select a Title"  
            
            obj1="Select a Title"
            id1=0
             _empty=""    
          #  page.alert("choose title")         
             page<<"$('Tlabeldetails_1').options.selectedIndex=0"
             
             page.replace_html 'error_msg', "WRONG"
             page.replace_html 'ok_msg', ""
             page['labeldetails_1'].value=_empty
                page.visual_effect :highlight,'error_msg', :duration=>2.5
             else
               _msg="OK"
               page['labeldetails_1'].value=@phrase1
             # page.alert("Title Validation:"+_msg)
             page.replace_html 'error_msg', ""
             page.replace_html 'ok_msg', "OK!"
             #page['labeldetails_4'].value=@results1
             end 
          
            end #render :update do |page|
               }
           end #respond_to do |format|
       
 end  #validatetitle_1





def validatetitle_3
   @phrase1=[]
       @phrase2=[]
         @msg=""
         msg1="" 
         msgbeg=""
         @sel=[]  #select_tag
        @phrase1=params[:Tlabeldetails_3] 
           
   if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<2 or @phrase1.size>15
     msgbeg="CHOOSE TITLE!!!"
     @msg=msgbeg
     
    else    
       msgbeg="ok" 
       @msg="ok"
   end   
   respond_to do |format|
      
       
         format.js {              
         render :update do |page|            
            _msg=@msg
      
            #if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
           if msgbeg!="ok"                             
          #  page.alert("Title Validation:"+_msg)
           # end 
            @results1="Select a Title"  
            
            obj1="Select a Title"
            id1=0
                 
          #  page.alert("choose title")         
             page<<"$('Tlabeldetails_3').options.selectedIndex=0"
             page['labeldetails_3'].value=""
             page.replace_html 'error_msg1', "WRONG"
             page.replace_html 'ok_msg1', ""
             
                page.visual_effect :highlight,'error_msg1', :duration=>1.5
             else
               _msg="OK"
               page['labeldetails_3'].value=@phrase1
             # page.alert("Title Validation:"+_msg)
             page.replace_html 'error_msg1', ""
             page.replace_html 'ok_msg1', "OK!"
             #page['labeldetails_4'].value=@results1
             end 
          
            end #render :update do |page|
               }
           end #respond_to do |format|
       
 end  #validatetitle_6



def deletemultiple
  @user_id=params[:uid]
	con=params[:to_be_deleted]
	  
	  if con.nil?
		  else
	  con.each do|cid, do_it|
		  if do_it=="yes"
			  @deletions=Contact.find(:all, :conditions=>"contactid='#{cid}'")
			 
			 @deletions.each do |@deletion|
			  @deletion.destroy
			end
		end
	end
	end
     redirect_to :action => 'viewsummary', :uid=>@user_id
end

def view	  
	 @contact_pages #, @contacts = paginate :contacts, :per_page => 30
    @user_id=params[:uid]||params[:id]
	 listid=1
    listid=params[:id]
 flash.now[:notice] = "#{params[:arg1]}"
    if listid.nil?
	    listid=params[:selectview]
	    flash.now['notice'] = " ID IS new :#{@params[:arg1]}"
	    if listid.nil?
		    listid=1
		    flash.now['notice'] = " No ID chosen"
	end
	end
	@contacts=Contact.find(:all, 
			:conditions=>"contactid=#{listid} and userid=#{@user_id}",
			:order=>["labelnumber"])
	if  params[:id].nil?
		@picture=Picture.find(15)
	else
			@c=Contact.find(:first,
			 :conditions=> "contactid=#{listid} and labelnumber=101")
			 id1=1
		 if @c.nil?
			 id1=15
			else
			 id1=(@c.labeldetails).to_i 
			 
		end
	end		
			
  end

 def viewsummary  
	 @contact_pages #, @contacts = paginate :contacts, :per_page => 30
  @user_id=0
	 @user_id=params[:uid]
	   if @user_id.nil?
	     if params[:id].nil?
	     @user_id=0
	     else
	     @user_id=params[:id]
	     end #if params[:id].nil?
	   end #if user_id.nil?
	#@msg_login=""
	 @msg_login=params[:msg1]
 #  Contact.update(:conditons=>"user_id=#{params[:id]} and labelnumber=130",:labeldetails => 90) 
  # time_entry=Time.now.strftime("%Y-%m-%d %H:%M:%S")
	 #  @log_in_change=Contact.find(:first, :conditions=>"userid=#{params[:id]} and labelnumber=130") 
   #@log_in_change.update_attributes({:labeldetails=>time_entry})
	  # if @request.cookies["_session_id"].to_s==""
	  #     render :text=> "<html><body>"+"YOU NEED COOKIES"+"</body></html>"	 
	 #  end  
	  if @msg_login=="LOGIN SUCCESSFUL!!!!" 
   
     flash[:notice] = @msg_login
	  end
	   
	  #flash[:message] = "Login Successful1! Welcome to the member area"
 
     @login_time=session[:time]
    @username=session[:username]  
	 #get names array from session    
    unless @names    #if array doesn't exist make one
     @names=[]  
    end  
	   @names=session[:names] 
   @previous_name=cookies[:name]
	   
	@contactsall=Contact.find(:all, :conditions=>"labelnumber=101")  
	@parent=Contact.find(:all, :conditions=>"contactid=#{@user_id}",
				:order=>["labelnumber"]) ##only records for login_user
   @children=Contact.find(:all, :conditions=>"labelnumber=150 and userid=#{@user_id} and contactid<>#{@user_id}",
           :order=>["labelnumber"]) ##only records for contacts created by login_user			  
	
	if @contacts.nil?
	end

	  @labels=Label.find(:all)
	  
end  #viewsummary


  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        flash[:notice] = 'Contact was successfully created.'
        format.html { redirect_to(@contact) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:notice] = 'Contact was successfully updated.'
        format.html { redirect_to(@contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
