class ContactsController < ApplicationController
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
    
    #@Invoices=Invoice.find(:all)
    #@Invoices=Invoice.find(:first, :order=>"invoiceid DESC")
    #@labels=OrderLabel.find(:all)
    #@invoicedate=Contact.find(:first, :conditions=>"labelnumber=156 and contactid=#{conid}")  
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
        :created_at=>item4[x]
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
  
  
  
  
  
  
  
  
  
  
  
  
  
   
   def quickentry
  
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
		  :created_at=>item4[x]
		  )
	      @contact.save!
	      x=x+1
	      y=y+1
      end
      end
       #flash.now[:notice] = 'Contact was successfully created.'
      redirect_to :action => 'view', :id => @contact.contactid
end
end

def deletemultiple
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
     redirect_to :action => 'viewsummary'
end

def view	  
	 @contact_pages #, @contacts = paginate :contacts, :per_page => 30
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
			:conditions=>"contactid=#{listid}",
			:order=>["labelnumber"])
	if  params[:id].nil?
		@picture=Picture.find(15)
	else
			@c=Contact.find(:first,
			 :conditions=> "contactid=#{listid} and labelnumber=921")
			 id1=1
		 if @c.nil?
			 id1=15
			else
			 id1=(@c.labeldetails).to_i 
			 #if id1>0
				#@picture=Picture.find(id1)
			#end
		end
	end		
			
  end

 def viewsummary  
	 @contact_pages #, @contacts = paginate :contacts, :per_page => 30
   
	@contactsall=Contact.find(:all, :conditions=>"labelnumber=150")  
	@contacts=Contact.find(:all, 
				:order=>["contactid, labelnumber"])
	
	if @contacts.nil?
	end

	  @labels=Label.find(:all)
	  
end












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
