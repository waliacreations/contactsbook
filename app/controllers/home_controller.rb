class HomeController < ApplicationController
     #before_filter :authorize
  # session :off
  #session :on, :only => [:create, :update]
   
  # end #private
   
 # validates :password, :presence => true,
  #                   :confirmation => true,
  #                   :length => {:within => 6..40},
  #                   :unless => :force_submit
  
  
  def logout
    @msg_login="YOU ARE LOGGED OUT"
    #session[:email]=nil
    session[:time]=nil
   # session[:names]=nil
    session[:username] = nil
   session[:user_id]=nil 
   reset_session
      #flash[:notice] = 'Logged out'
    flash[:notice] = "You have been successfully logged out !"
     # redirect_to(:action =>'index', :msg1=>@msg_login)        
    #page.delay(20) do 
     # sleep(2) #is 2 seconds  
             
    #sleep(4.minutes)
    # or, even longer...
   # sleep(2.hours);            
  end
  
 
  def index
    params[:msg]||=""
    flash[:notice]||=" "+params[:msg]+" "+" PLEASE LOG IN/REGISTER  "
    # flash[:message]||="PLEASE LOG IN/REGISTER" 
    #flash[:message]||="PLEASE LOG IN/REGISTER" 
    if @msg_login=="YOU ARE LOGGED OUT"
     flash[:notice] = @msg_login
    end
        
    @username_login=""
    
  end
  
  
   def login
     @item1=[]
     @msg_login="" 
     @item2=[]
     @msg_password=""  
      userid_search=0  
     #extract username     
     to_user=params[:username]
     if to_user
        #will start with 1
        to_user.each do |key, value|
        x= key.to_f
        flash[:notice] =x
        @item1[x]=value
        end
        end
      @msg_login=@item1[1]
      @username_login=@item1[1]
          
      #extract password
      to_password=params[:password]  
        if to_password
        #will start with 1
        to_password.each do |key, value|
        x= key.to_f
        flash[:notice] =x
        @item2[x]=value
        end
        end
      @msg_pssword=@item2[1]
      @username_password=@item2[1]
        
      if  session[:username]==@username_login
        flash[:notice]="THIS email/username already logged in!"
        redirect_to :controller=>'contacts',:action => 'viewsummary', :id =>session[:user_id], :uid=>session[:user_id], :cid=>session[:user_id] 
      else
        
       @username_match=Contact.find(:first,:conditions=>"labelnumber=101 and labeldetails LIKE '#{@username_login}'")
        userid_search=@username_match.userid     
       @username_match2=Contact.find(:first,:conditions=>"labelnumber=111 and userid=#{userid_search}")
      #if @msg_login=="waliacreations@yahoo.com" ## here check if username/pwd correct
        if @msg_login==@username_match.labeldetails and @username_password==@username_match2.labeldetails
        
        @msg_login="LOGIN SUCCESSFUL!!!!"
         flash[:notice] = "Login Successful! Welcome to the member area"
          ####cookies:
           @previous_name=cookies[:name]
           @name=@username_login
           #cookies[:name]={:value=>@name, :path=>'/index', :domain=>'http://contactsbook.heroku.com'}
           cookies[:name]={:value=>@name, :path=>'/index', :expires=>12.hours.from_now} 
           
           #####sessions:  #
            @names=session[:names]    #get names array from session
               
             unless @names    #if array doesn't exist make one
               @names=[]  
             end
             
              if @name    #add new name to names array
                 @names<<@name
               end 
           time_entry=Time.now.strftime("%Y-%m-%d %H:%M:%S")
              @log_in_change=Contact.find(:first, :conditions=>"userid=#{userid_search} and labelnumber=130") 
             @log_in_change.update_attributes({:labeldetails=>time_entry})
            #session[:email]||=@username.login #if session[:email] exists or=@username.login        
            session[:time]=Time.now.strftime("%d-%m-%y %H:%M:%S")
             session[:names]=@names
             session[:username]= @username_login  
               
         redirect_to(:controller=>"contacts",:action=>"viewsummary",:uid=>@username_match.userid,:id=>@username_match.userid, :msg1=>@msg_login)
#redirect_back_or_default(:controller=>"contacts",:action=>"viewsummary",:id=>1, :msg1=>@msg_login)
     
          else 
          flash[:notice]="THIS EMAIL NOT REGISTERED OR CHECK PASSWORD MAYBE WRONG!!!!"
          redirect_to(:controller=>"home",:action=>"index") 
            
        end  #if @msg_login==@username_match.labeldetails 
   
        
      end #if  session[:username]==@username_login
               
                       
    end  #def login
  
  
    
def validateusername_1    ###NEW USER REGISTERATION EMAIL CHECK IF EMAIL ALREADY REGD
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
      msg8=""
      msgbeg=""
      msgbeg1=""
    emailsearch1="" 
    emailsearch2="" 
    @results1=""
    @results2=""
    @results3=""
    @emailbegin=[]
    @emailend=[]
    @phrase1=params[:labeldetails_1]

      
          
 if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<9
   msgbeg="ENTER EMAIL!!!"
   msg+=msgbeg
  else    
    
    #emailsearch1=@phrase1.downcase  # search for same email whether upcase or downcase
   # emailsearch2=@phrase2.upcase
   @existingemail=Contact.find(:first, :conditions=>"labelnumber=101 and labeldetails LIKE '#{@phrase1}'")    ###check if user email already exists????
    if @existingemail.nil?  ##email should not exist
      
   
    
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
  
if @phrase2[0].nil? or @phrase2[0].to_s==""    #if nothing before @ or there is space 
  msg7="number only before '@' check email: "
  @results1=""
  msg+=msg7
else
  msg7="ok"
end  

if @phrase2[0].match(/\A[\w\b]{1,15}\z/)#\w  Word characters [a-zA-Z_0-9]
msg8="ok"
else
msg8="check email part before @ only numbers,_ and words"
msg+=msg8
@results="1"
end  #if @phrase2[0].match(/\A[\w\b]{1,15}\z/

 end  #if @phrase2[1]=="" or @phrase2[1].nil?  
else
msgbeg=" EMAIL ALREADY EXIST!!!"
 msg+=msgbeg
end # if @existingemail.nil?  ##email should not exist

  end # if @phrase1=="" or @phrase1.nil?
  
   respond_to do |format|
       format.js {
        render :update do |page|
         
    _msg=msg
   if msgbeg!="ok"||msgbeg1!="ok"||msg8!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
            #page.alert("Email Validation:"+_msg)
            @results1=""
            #page['labeldetails_1'].value=@results1
            page.replace_html 'error_msg5', ""+_msg
            page.replace_html 'ok_msg5', ""  
            #page['labeldetails_1'].focus()  
            else
              _msg="OK"
            # page.alert("Email Validation:"+_msg) 
          page.replace_html 'error_msg5', ""
           page.replace_html 'ok_msg5', ""+_msg
             
            end 
         
           end #render :update do |page|
              }
          end #respond_to do |format|
  
   end #validatelogin_1 
    
    
    def validatetitle_4
      @phrase1=[]
          @phrase2=[]
            @msg=""
            msg1="" 
            msgbeg=""
            @sel=[]  #select_tag
           @phrase1=params[:Slabeldetails_4] 
              
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
               #page.alert("Title Validation:"+_msg)
              # end 
               @results1="WRONG!Select a Title"  
               
               obj1="Select a Title"
               id1=0
                    
              # page.alert("choose title")         
                page<<"$('Slabeldetails_4').options.selectedIndex=0"
                
                page.replace_html 'error_msg2', @results1
                page.replace_html 'ok_msg2', ""
                
                   page.visual_effect :highlight,'error_msg2', :duration=>1.5
                else
                  _msg="OK"
                  page['labeldetails_4'].value=@phrase1
                # page.alert("Title Validation:"+_msg)
                page.replace_html 'error_msg2', ""
                page.replace_html 'ok_msg2', "OK!"
                #page['labeldetails_4'].value=@results1
                end 
             
               end #render :update do |page|
                  }
              end #respond_to do |format|
          
    end  #validatetitle_4
   
   

    
    
def validatename_5
    @phrase1=[]
    @phrase2=[]
      @msg=""
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
    @phrase1=params[:labeldetails_5]
      
 if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<2 or @phrase1.size>15
   msgbeg="ENTER name between 2 and 15 characters(NO '?')!!!"
   @msg=msgbeg
   
  else    
     msgbeg="ok" 
     @msg="ok"
  
    #if @phrase1.match /\A[a-zA-Z]+\z/  ##only letters
     
    #if @phrase1.match(/\A[\w\.\_\-\+]+\z/) #letters,numbers,+,-
     #/^[\w\-@]*$/
   
  
     
     if @phrase1.match(/\A[a-zA-Z\s\.+]+\z/)
     
       msgbeg1="ok"
      @msg="CORRECT FIRST NAME:)"
    else
     
      
      msgbeg1="enter words,space,. only"
      @msg=msgbeg1
    end 

     
    
 end # if @phrase1=="" or @phrase1.nil?  
 
   
   respond_to do |format|
     #render :text => "Check PASSWORD"
     # page.replace_html 'warning', "Invalid options supplied"
     
       format.js {
         
       render :update do |page|
       
          _msg=@msg
    
          #if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
         if msgbeg!="ok" || msgbeg1!="ok"
          #if _msg=="ENTER PASSWORD!!!"  ##don't show if only box is empty
        
         #if msgbeg.to_s=="ok"
         
          page.alert("FirstName Validation:"+_msg)
         # end 
          @results1=""
               
           page['labeldetails_5'].value=@results1
       
             page.replace_html 'error_msg3', "WRONG"
           page.replace_html 'ok_msg3', ""
              page.visual_effect :highlight,'error_msg3', :duration=>1.5
           else
             _msg="OK"
           # page.alert("FirstName Validation:"+_msg)
           page.replace_html 'error_msg3', ""
           page.replace_html 'ok_msg3', "OK!"
           #page['labeldetails_5'].value=@results1
           end 
        
          end #render :update do |page|
             }
         end #respond_to do |format|

         
  end #validatename_5 
    
def validatename_6
    @phrase1=[]
    @phrase2=[]
      @msg=""
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
    @phrase1=params[:labeldetails_6]
      
 if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<2 or @phrase1.size>15
   msgbeg="ENTER name between 2 and 15 characters(NO '?')!!!"
   @msg=msgbeg
   
  else    
     msgbeg="ok" 
     @msg="ok"
  
    #if @phrase1.match /\A[a-zA-Z]+\z/  ##only letters
     
    #if @phrase1.match(/\A[\w\.\_\-\+]+\z/) #letters,numbers,+,-
     #/^[\w\-@]*$/
   
  
     
     if @phrase1.match(/\A[a-zA-Z+]+\z/)
     
       msgbeg1="ok"
      @msg="CORRECT LAST NAME:)"
    else
     
      
      msgbeg1="enter words only"
      @msg=msgbeg1
    end 

     
    
 end # if @phrase1=="" or @phrase1.nil?  
 
   
   respond_to do |format|
     #render :text => "Check PASSWORD"
     # page.replace_html 'warning', "Invalid options supplied"
     
       format.js {
         
       render :update do |page|
       
          _msg=@msg
    
          #if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
         if msgbeg!="ok" || msgbeg1!="ok"
          #if _msg=="ENTER PASSWORD!!!"  ##don't show if only box is empty
        
         #if msgbeg.to_s=="ok"
         
        #  page.alert("LASTName Validation:"+_msg)
         # end 
          @results1=""
               
           page['labeldetails_6'].value=@results1
       
             page.replace_html 'error_msg4', "WRONG"
           page.replace_html 'ok_msg4', ""
              page.visual_effect :highlight,'error_msg4', :duration=>1.5
           else
             _msg="OK"
           # page.alert("LASTName Validation:"+_msg)
           page.replace_html 'error_msg4', ""
           page.replace_html 'ok_msg4', "OK!"
           #page['labeldetails_6'].value=@results1
           end 
        
          end #render :update do |page|
             }
         end #respond_to do |format|

         
  end #validatename_6 
  
def validatepassword_2
    @phrase1=[]
    @phrase2=[]
      @msg=""
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
    @phrase1=params[:labeldetails_2]
      
 if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<3 or @phrase1.size>15
   msgbeg="ENTER PASSWORD between 3 and 15 characters!!!"
   @msg=msgbeg
   
  else    
     msgbeg="ok" 
     @msg="ok"
  
    #if @phrase1.match /\A[a-zA-Z]+\z/  ##only letters
     
    #if @phrase1.match(/\A[\w\.\_\-\+]+\z/) #letters,numbers,+,-
     #/^[\w\-@]*$/   OR(/\A[\w\+]+\z/)
   
  
     
    # if @phrase1.match(/\A[\w\d]+\z/)  #\w  Word characters [a-zA-Z_0-9]
   if @phrase1.match(/\A[\w\b]{3,15}\z/)  #\w  Word characters [a-zA-Z_0-9]
       msgbeg1="ok"
      @msg="CORRECT PASSWORD:)"
    else
     
      
      msgbeg1="enter words,numbers,underscore only. No space/?/.etc."
      @msg=msgbeg1
    end 

 end # if @phrase1=="" or @phrase1.nil?  
 

   
   
   respond_to do |format|
     #render :text => "Check PASSWORD"
     # page.replace_html 'warning', "Invalid options supplied"
     
       format.js {
         
       render :update do |page|
       
          _msg=@msg
    
          #if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
         if msgbeg!="ok" || msgbeg1!="ok"
          #if _msg=="ENTER PASSWORD!!!"  ##don't show if only box is empty
        
         #if msgbeg.to_s=="ok"
         
         # page.alert("Password Validation:"+_msg+"! "+@phrase1)
         # end 
          @results1=""
               
           page['labeldetails_2'].value=@results1
           page['labeldetails_3'].value=@results1
           #page['labeldetails_1'].focus() 
           #return false;
           #page.replace_html "update_new", :partial => "update_index" #_update_index.erb
           #page.delay(5)
             #page.hide['update_new']
             #page.insert_html :bottom, 'update_new', '<table></table><p> HEELOOO!!!!</p>'
             page.replace_html 'error_msg', "WRONG"
           page.replace_html 'ok_msg', ""
              page.visual_effect :highlight,'error_msg', :duration=>2.5
           else
             _msg="OK"
            #page.alert("Password Validation:"+_msg+"! "+@phrase1)
           page.replace_html 'error_msg', ""
           page.replace_html 'ok_msg', "OK!"
           #page['labeldetails_3'].value=@results1
           
           end 
        
          end #render :update do |page|
             }
         end #respond_to do |format|

         
  end #validatepassword_2 
      
  
    
    
def validatepassword_3
    @phrase1=[]
    @phrase2=[]
      @msg=""
      msg1=""
      msg2=""
      
    @results1=""
    @results2=""
    @results3=""
    
    @phrase1=params[:labeldetails_3]
     
 
if @phrase1.match(/\A[\w\b]{3,15}\z/)
    msgbeg="ok"
   @msg="ok"
 else
   msgbeg="ENTER  same PASSWORD in both!!!"
   @msg=msgbeg
   
 end
  
      
     respond_to do |format|
     #render :text => "Check PASSWORD"
     # page.replace_html 'warning', "Invalid options supplied"
     
       format.js {
         
       render :update do |page|
       
        
       _msg=@msg
       
          #if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
         
         
                
    
        if msgbeg!="ok"   ##password notcorrect!!!
          
         # page.alert("Password Validation:"+_msg+"! ")
         # end 
          @results2=""
           page['labeldetails_2'].value=@results2   
           page['labeldetails_3'].value=@results2
           #page['labeldetails_1'].focus() 
           #return false;
           #page.replace_html "update_new", :partial => "update_index" #_update_index.erb
           #page.delay(5)
             #page.hide['update_new']
             #page.insert_html :bottom, 'update_new', '<table></table><p> HEELOOO!!!!</p>'
             page.replace_html 'error_msg1', "WRONG"
          page.replace_html 'error_msg', "WRONG"  
           page.replace_html 'ok_msg1', ""
          page.replace_html 'ok_msg', ""
              page.visual_effect :highlight,'error_msg1', :duration=>1.5
           else
             #passwords match validation
             _msg="OK"
           
            page<< 'var label1=$("labeldetails_2");
                  var opt21=document.getElementById("labeldetails_2").value;
                 // alert("PASSWORD1:"+opt21);
                    var label2=$("labeldetails_3");
                           var opt22=document.getElementById("labeldetails_3").value;
                          // alert("PASSWORD2:"+opt22);
                   
                    var opt23="";
                         opt23=opt21+":"+opt22;
                      var message="";
                     if (opt21==opt22){
                      message="PASSWORDS MATCH";
          
          document.getElementById("error_msg1").innerHTML="";
          document.getElementById("error_msg").innerHTML="";
          document.getElementById("ok_msg1").innerHTML="DONE!";
          document.getElementById("ok_msg").innerHTML="DONE!"; 
             
                   }
                     else{
            var _empty="";
                      message="NOT MATCHING TRY AGAIN";
         document.getElementById("labeldetails_2").value=_empty;
         document.getElementById("labeldetails_3").value=_empty;
                      
          document.getElementById("error_msg1").innerHTML="WRONG!!!";
                    document.getElementById("ok_msg1").innerHTML="";   
          document.getElementById("error_msg").innerHTML="WRONG!!!";
                              document.getElementById("ok_msg").innerHTML=""; 
                
                         }
                     //alert("MATCH:"+opt23+message);   
            
        //  curStyle = document.getElementById("divTitle").currentStyle;
          //document.getElementById("displayed").innerHTML = responseHTML.innerHTML;
         // alert(curStyle.fontWeight);
                 
                //var optGrps1=label1.getElementsByTagName("optgroup").length; ' 
    
            # page.alert("Password Validation:"+_msg+"! ")
           #page.replace_html 'error_msg1', ""
           #page.replace_html 'ok_msg1', "DONE!"
           end 
        
          end #render :update do |page|
             }
         end #respond_to do |format|

         
  end #validatepassword_3 
  
  
  
  
  
  
  def validateusername
    
    @msg_login="PLEASE LOG IN:"         
    @username_password=""
     @last_login=""   
     @last_loginarray=[]
    @username_login=params[:username_1]
   # @password_login=params[:password_1]
      
    @username_match=Contact.find(:first,:conditions=>"labelnumber=101 and labeldetails LIKE '#{@username_login}'") 
      if @username_match.nil?
        @username_password=""
      else
        @username_password=@username_match.labeldetails
      end
    
    
       if @username_login==@username_password
         @msg_login="OK!!!!"
         @last_loginarray=Contact.find(:first,:conditions=>"labelnumber=130 and userid=#{@username_match.userid}") 
         @last_login=@last_loginarray.labeldetails
       else
         @msg_login="WRONG EMAIL! NOT REGISTERED!!!" 
           
           if @username_login.blank? or @username_login==""
          @msg_login="" 
           else
           @msg_login="WRONG:!!!"     
         end #if params[:username].blank?
                    
        end      # if (@username_login.to_s).downcase=="waliacreations@yahoo.com" 
          
        
         respond_to do |format|
                        format.js {
                        render :update do |page|
                          _empty=""
                           if  @msg_login=="OK!!!!"
                            # page.alert(@msg_login+@username_login)
                             page.replace_html 'last_login', "PREVIOUS LOGIN:"+@username_login+":"+@last_login+"("+time_ago_in_words(@last_login)+" ago)"
                             page.replace_html 'error_msg6', ""
                             page.replace_html 'ok_msg6', ""+@msg_login
                           else
                           
                          if @msg_login=="" or @msg_login.blank?
                           # page.alert("blank entry!!!:"+@msg_login)
                            #page['username_1'].value=_empty
                            page.replace_html 'error_msg6', "WRONG blank entry!!!:"
                            page.replace_html 'ok_msg6', ""
                          else
                         # page.refresh
                         # page.alert(@msg_login)                          
                        #page['username_1'].value=_empty
                         # page['username_1'].focus() 
                            page.replace_html 'error_msg6', @msg_login
                            page.replace_html 'ok_msg6', ""
                                             
                                                        
                          end  #if @msg_login=="" or @msg_login.blank?
                          end  # if  @msg_login="LOGIN SUCCESSFUL!!!!"
                            
                          end #render :update do |page|
                             } #format.js
                          end #respond_to do |format|
     
      
  end #validate login
    
def validatepassword  #validate password for login
    @phrase1=[]
    @phrase2=[]
      @msg=""
      msg1=""
      msg2=""
      msg3=""
      msg4=""
      msg5=""
      msg6=""
      msg7=""
      msgbeg=""
      msgbeg1=""
      msgbeg2=""
    @results1=""
    @results2=""
    @results3=""
    @emailbegin=[]
    @emailend=[]
    @phrase1=params[:password_1]
      
 if @phrase1.to_s=="" or @phrase1.to_s==" " or @phrase1.nil? or @phrase1.size<3 or @phrase1.size>15
   msgbeg="ENTER PASSWORD between 3 and 15 characters!!!"
   @msg=msgbeg
   
  else    
     msgbeg="ok" 
     @msg="ok"
  
    #if @phrase1.match /\A[a-zA-Z]+\z/  ##only letters
     
    #if @phrase1.match(/\A[\w\.\_\-\+]+\z/) #letters,numbers,+,-
     #/^[\w\-@]*$/   OR(/\A[\w\+]+\z/)
   
  
     
    # if @phrase1.match(/\A[\w\d]+\z/)  #\w  Word characters [a-zA-Z_0-9]
   if @phrase1.match(/\A[\w\b]{3,15}\z/)  #\w  Word characters [a-zA-Z_0-9]
       msgbeg1="ok"
      @msg="CORRECT PASSWORD:)"
      
     @password_match=Contact.find(:first,:conditions=>"labelnumber=111 and labeldetails LIKE '#{@phrase1}'") 
           if @password_match.nil?
             @username_password=""
             msgbeg2="INCORRECT PASSWORD"
             @msg="INCORRECT PASSWORD"
           else
             @username_password=@password_match.labeldetails
             msgbeg2="ok"
             @msg="ACCEPTING PASSWORD:)"
           end #if @password_match.nil?
      
      
      
      
    else
     
      
      msgbeg1="enter words,numbers,underscore only. No space/?/.etc."
      @msg=msgbeg1
    end 

 end # if @phrase1=="" or @phrase1.nil?  
 

   
   
   respond_to do |format|
     #render :text => "Check PASSWORD"
     # page.replace_html 'warning', "Invalid options supplied"
     
       format.js {
         
       render :update do |page|
       
          _msg=@msg
    
          #if msgbeg!="ok"||msgbeg1!="ok"||msg1!="ok" || msg2!="ok" || msg3!="ok" || msg4!="ok" || msg5!="ok" || msg6!="ok" || msg7!="ok"
         if msgbeg!="ok" || msgbeg1!="ok"|| msgbeg2!="ok"
          #if _msg=="ENTER PASSWORD!!!"  ##don't show if only box is empty
        
         #if msgbeg.to_s=="ok"
         
         # page.alert("Password Validation:"+_msg+"! "+@phrase1)
         # end 
          @results1=""
               
         #  page['password_1'].value=@results1
          #page['labeldetails_3'].value=@results1
           #page['labeldetails_1'].focus() 
           #return false;
           #page.replace_html "update_new", :partial => "update_index" #_update_index.erb
           #page.delay(5)
             #page.hide['update_new']
             #page.insert_html :bottom, 'update_new', '<table></table><p> HEELOOO!!!!</p>'
             page.replace_html 'error_msg7', "WRONG"
           page.replace_html 'ok_msg7', ""
              page.visual_effect :highlight,'error_msg7', :duration=>1.5
           else
             _msg="OK"
            #page.alert("Password Validation:"+_msg+"! "+@phrase1)
           page.replace_html 'error_msg7', ""
           page.replace_html 'ok_msg7', "OK!"
           #page['labeldetails_3'].value=@results1
           
           end 
        
          end #render :update do |page|
             }
         end #respond_to do |format|

         
  end #validatepassword 
      
   
  
    
def createlogin   ###NBW USER REGISTERATION
  
  #cid=params[:id]
  @contactlast=[]
  cid=""
  record_create=""
  
   if cid.nil? or cid=="" 
    else
     @deletions=Contact.find(:all, :conditions=>"contactid='#{cid}'")
    
    @deletions.each do|@deletion|      
    @deletion.destroy
      end
  end #if cid.nil?
    
   #flash['notice'] = 'Contact was successfully created.'
  @contacts=Contact.find(:all)
  @labels=Label.find(:all)
  new_contact=Contact.new
  @contact=Contact.new
  @contactlast=Contact.find(:first,:conditions=>"labelnumber=101", :order=>"contactid DESC")
      if @contactlast.nil? or @contactlast==""
        cid=1
      else
        cid=(@contactlast.contactid).to_i
        cid+=1
      end
      
      time_entry=Time.now.strftime("%Y-%m-%d %H:%M:%S")
      
  #@contact=Contact.create(params)   #:labeldetails,:contactid,:time_at])
  x=0
  
  item1=[]
  item2=[]
 
  to_create1=params[:labelnumber]
  to_create2=params[:labeldetails]
 
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
   
  x=1  ###warning make sure labeldetails_1 ie. starts with 1
  y=1
    
  if item1[x].nil?     #ie. if labeldetails_1 is nil???
      render :action => 'index'
       flash.now['notice'] = 'NEW REGISTERATION NOT DONE!!!.'
      else
    # cid=item3[x]
  if cid.nil?
    else
     @deletions=Contact.find(:all, :conditions=>"contactid='#{cid}'")
    
    @deletions.each do|@deletion|
      
    @deletion.destroy
  end  #@deletions.each do|@deletion|
  end   # if cid.nil?
        
        
   item1.each do
    if item2[x].nil? or item2[x]==""
      x=x+1
    else
      @contact= Contact.create(
      :labelnumber=>item1[x],
      :labeldetails=>item2[x],
    :created_at=>time_entry,
     :updated_at=>time_entry,
      :userid=>cid,
      :contactid=>cid
      )
        @contact.save!
        x=x+1
        y=y+1
         record_create="yes"    
      end #if item2[x].nil? or item2[x]==""
      end #item1.each do
      
      if record_create=="yes"  ##create last_login for this user
            @contact= Contact.create(
              :labelnumber=>130,
              :labeldetails=>Time.now.strftime("%Y-%m-%d"),
              #:contactid=>cid,
             :created_at=>time_entry,
               :updated_at=>time_entry,
              :userid=>cid,
              :contactid=>cid
              )
                @contact.save!
            ##enter created_on    
        @contact= Contact.create(
                      :labelnumber=>131,
                      :labeldetails=>Time.now.strftime("%Y-%m-%d"),
                      #:contactid=>cid,
                     :created_at=>time_entry,
                       :updated_at=>time_entry,
                      :userid=>cid,
                      :contactid=>cid
                      )
                     @contact.save! 
      end #if record_create=="yes"
      
         
      @msg_login=item2[1] #labeldetails_1
      @username_login=item2[1]  #labeldetails_1           
      
         @msg_login="LOGIN SUCCESSFUL!!!!"
         flash[:notice] = "Login Successful! Welcome to the member area"
          ####cookies:
           @previous_name=cookies[:name]
           @name=@username_login
           #cookies[:name]={:value=>@name, :path=>'/index', :domain=>'http://contactsbook.heroku.com'}
           cookies[:name]={:value=>@name, :path=>'/index', :expires=>12.hours.from_now} 
           
          #####sessions:  
             @names=session[:names]    #get names array from session
               
             unless @names    #if array doesn't exist make one
               @names=[]  
             end
             
              if @name    #add new name to names array
                 @names<<@name
               end 
                
            session[:time]=Time.now.strftime("%d-%m-%y %H:%M:%S")           
            session[:names]=@names
            session[:username]= @username_login  
            session[:user_id]=@contact.userid
 end #if item1[x].nil?               
               
if record_create=="yes"
        flash.now[:notice] = 'Contact was successfully created.'
        redirect_to :controller=>'contacts',:action => 'viewsummary', :id =>@contact.userid , :cid=>@contact.userid
else
  flash.now[:notice] = 'PLEASE ENTER PROPERLY!!!! in THE TEXT BOXES.'
  flash.now[:message] = 'PLEASE ENTER PROPERLY!!!! in THE TEXT BOXES.!!'  
  redirect_to :controller=>'home',:action => 'index' , :msg=>'PLEASE ENTER PROPERLY!'
end     #if record_create=="yes"  
        #redirect_back_or_default(:controller=>"contacts",:action=>"viewsummary",:id=>@contact.userid, :msg1=>@msg_login)


 

end #createlogin()
     
  
  
  
  
       

  
end  #class HomeController < ApplicationController
