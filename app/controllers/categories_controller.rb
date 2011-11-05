class CategoriesController < ApplicationController
  #before_filter :authorize
  
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(@category) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
  
  def subcategory_1
    
    
    @subcategory_val=params[:category_1]
     
      if @subcategory_val.nil? or @subcategory_val.blank?
      else
      @category=Category.find(:all)
   # @category=Category.find(:all, :conditions=>"group LIKE '%Gym%' ")    
        
        
    respond_to do |format|
      #format.html {render :text=> "HEEELLOOO1 HTML!"}
        format.js {
        render :update do |page|
          
        
        #page.alert('Hello Rails')
        #page << "alert('Im JS'+_subcategory_val)"
       page.alert("Heelloo2 JS: "+@subcategory_val)
    #    page.alert("Heelloo2 JS: ")
      page['vehicle_new_1'].length=0
       #page['labeldetails_4'].value=@phrase1[0]
        #page.replace_html 'vehicle_new1', :partial => 'updateselect'
        # START OF LIST FOR SELECTION
    id1=0
    id2=1
    
    #start of optgroup already existing
   page<<'var label1=$("vehicle_new_1");
   var optGrps1=label1.getElementsByTagName("optgroup").length;
   var optGrps22=document.createElement("OPTGROUP");
   optGrps22=label1.getElementsByTagName("optgroup");
  //var killGrps=optGrps22.item(choice);
   alert("OPTGROUPS1:"+optGrps1);
   if (optGrps1>0) {
    label1.removeChild(optGrps22.item(optGrps1-1));
    for (var i=0;i<label1.getElementsByTagName("optgroup").length; i++){
   optGrps22[i].label="";
    $("vehicle_new_1").removeChild(optGrps22[i]);
  }
   //label1.removeChild(optGrps22.item(optGrps1-1));
   //label1.removeChild(optGrps22.item(optGrps1));
  }'
    
    #start opgroup type 2
   page<<'var optGrps=document.createElement("OPTGROUP");optGrps.label="Select or Type '+@subcategory_val+' Subgroup:";$("vehicle_new_1").appendChild(optGrps);'
    
         # page['new1'].value="#{stockdisc_s}" 
      #  page["category_subgroup"].value="#{escape_javascript(@subcategory_val)}"
     #   page<<"$('new3').value=#{stockdiscamt_s.to_s}"
   
 # obj=""
 # id=0
   
   if @category.nil? or @category.blank?
     
     page.alert("no subgroup")
   else
   @category.each do |c|
  
     if c.group==@subcategory_val
     
          obj=c.subgroup
         # id=1
         #page<<"$('vehicle_new_1').options[$('vehicle_new_1').length]=new Option('#{escape_javascript(obj.to_s)}',#{id.to_i})" 
          page<<"$('vehicle_new_1').options[$('vehicle_new_1').length]=new Option('#{escape_javascript(obj.to_s)}','#{escape_javascript(obj.to_s)}')" 
    end #if c.group==@subcategory_val
   end #@category.each do |obj,id|
   end #if @category.nil?
    
   # page.alert("HI")
  #page.replace_html 'vehicle_new1', :partial => 'updateselect'
        end #render :update do |page|
        }
    end #respond_to do |format|
    
    
      end #if @subcategory_val.nil? or @subcategory_val.blank?
  end
  
  
  
end
