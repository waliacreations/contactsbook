class Contact < ActiveRecord::Base
#using will_paginate plugin
 cattr_reader :per_page
  @@per_page = 30




TITLE_TYPES=[
	["Mr.", "Mr."],
	["Mrs.", "Mrs."],
	["Miss", "Miss"]
	].freeze
	
	COMPANY_TYPES=[
	["SoleProprietorship","SoleProprietorship"],
	["PrivateLimited","PrivateLimited"],
	["Partnership","Partnership"],
	["PublicCo.","PublicCo."],
	["Unregistered","Unregistered"],
	].freeze
	
	GENERAL_TYPES=[
	["General Customer", "General Customer"],
	["General Supplier", "General Supplier"],
	["Currenta/c","Currenta/c"],
	["Savingsa/c","Savingsa/c"],
	["FDa/c","FDa/c"],
	["CreditCarda/c","CreditCarda/c"],
	["Credit Customer", "Credit Customer"],
	["Credit Supplier", "Credit Supplier"],
	["Employee", "Employee"],
	["UtilityAccount","UtilityAccount"],
	["GroupCompany", "GroupCompany"],
	["Owner/Proprietor","Owner/Proprietor"],
	["Shareholder/Partner", "Shareholder/Partner"],
	].freeze
	
	
	EMPLOYEE_TYPES=[
	["ManagementEmployee","ManagementEmployee"],
	["SalesEmployee", "SalesEmployee"],
	["AccountsEmployee","AccountsEmployee"],
	["ProductionEmployee","ProductionEmployee"],
	["DesignEmployee","DesignEmployee"],
	["HousekeepingEmployee", "HousekeepingEmployee"],
	["DeliveryEmployee","DeliveryEmployee"],
	["Proprietor","Proprietor"],
	["Partner","Partner"],
	["Shareholder","Shareholder"],
	["Consultant","Consultant"],
	].freeze
	
	MEMBER_TYPES=[
	["MembershipAccount", "MembershipAccount"],
	["UtilityAccount", "UtilityAccount"],
	["Monthly Subscription","Monthly Subscription"],
	["Platinum Member", "Platinum Member"],
	["Gold Member","Gold Member"],
	["Silver Member","Silver Member"],
	["Credit Supplier", "Credit Supplier"],
	["Credit Customer", "Credit Customer"],	
	["Savings a/c","Savings a/c"],
	["Current a/c","Current a/c"],
	["O/D a/c","O/D a/c"],
	["FDa/c","FDa/c"],
	["Demat a/c","Demat a/c"],
	["Forex a/c","Forex a/c"],
	["Trading a/c","Trading a/c"],	
	].freeze
	
	ENTITY_TYPES=[
	["Customer", "Customer"],
	["BankA/c","BankA/c"],
	["Employee","Employee"],
	["Shareholder/Partner", "Shareholder/Partner"],
	["Owner/Proprietor", "Owner/Proprietor"],
	["Supplier/Service provider", "Supplier"],
	["Reference/Acquaintance", "Reference"],
	["Friend", "Friend"],
	["Relative", "Relative"],
	["NGO/Organisation", "Organisation"],
	["Deptt./POS/Branch", "Branch"],
	["GroupCompany", "GroupCompany"],
	["FocusGroup","FocusGroup"],
	["RatingsAgency/Critics/Judges","Critics"],
	["Government/Tax Deptt./LicenceBoard", "Government"],
	].freeze
	
	RELATION_TYPES=[
	["Friend", "Friend"],
	["Employer", "Employer"],
	["Employee", "Employee"],
	["Father", "Father"],
	["Brother", "Brother"],
	["Sister", "Sister"],
	["Mother", "Mother"],
	["Wife", "Wife"],
	["Husband", "Husband"],
	["Son", "Son"],
	["Daughter", "Daughter"],
	["Cousin", "Cousin"],
	["Brother-in-law", "Brother-in-law"],
	["Sister-in-law", "Sister-in-law"],
	["Uncle", "Uncle"],
	["Aunty", "Aunty"],
	["Father-in-law", "Father-in-law"],
	["Mother-in-law", "Mother-in-law"],
	["Employer", "Employer"],
	["Employee", "Employee"],
	["Co-worker", "Co-worker"],
	].freeze
	
	
	PROFESSION_TYPES=[
	["Doctor","Doctor"],
	["Lawyer","Lawyer"],
	["Student", "Student"],
	["Retailer", "Retailer"],
	["Manufacturer", "Manufacturer"],
	["Accountant", "Accountant"],
	["Engineer", "Engineer"],
	["IT-Software", "IT-Software"],
	["Designer", "Designer"],
	["Architect", "Architect"],
	["Socialite", "Socialite"],
	["Model-Actor", "Model-Actor"],
	["Service provider", "Service provider"],
	["Finance and banking", "Finance and banking"],
	["Management", "Management"],
	["Education", "Education"],
	["Politics", "Politics"],
	["Real Estate", "Real Estate"],
	["Chartered Accountant", "Chartered Accountant"],
	].freeze
	
	STATE_TYPES=[
	["Delhi", "Delhi"],
	["Haryana", "Haryana"],
	["Uttar Pradesh", "Uttar Pradesh"],
	["Rajasthan", "Rajasthan"],
	].freeze
	
	
	#@labels=Label.find_all
    
	#labelnumber=[]
	#labeldetails=[]
	#time_at=[]
	#contactid=[]
	#@labels.each do |@label|
	#labelnumber<<@label.labelnumber
	#end
	
	
#end






end


EmployeeOption=Struct.new(:id, :name)
CustomerOption=Struct.new(:id, :name)
PartyOption=Struct.new(:id, :name)
SupplierOption=Struct.new(:id, :name)
class PartyHead
	attr_reader :type_name, :options
	
	def initialize(name)
		@type_name=name
		@options=[]
	end
	def <<(option)
	 @options<<option
	end
end
 PartySelection=PartyHead.new("PartySelection")
CustomerSelection=PartyHead.new("CustomerSelection")

 Customers=PartyHead.new("Customers")
 Employees=PartyHead.new("Employees")
 BankAccounts=PartyHead.new("BankAccounts")
 Owner=PartyHead.new("Owner")
GroupCompany=PartyHead.new("GroupCompany")
 Suppliers=PartyHead.new("Suppliers")
 Utilities=PartyHead.new("Utilities")
 Friends=PartyHead.new("Friends")
 customersall=[]
 employeesall=[]
 suppliersall=[]
 ownersall=[]
 serviceall=[]
 phonenum=[]
 conid=0
 customersall=Contact.find(:all, :order=>["contactid,labelnumber"], :conditions=>"labelnumber in (150,151,152,201,202,204,205)")
 partyid=Contact.find(:first,:order=>["contactid"])
 name=""
 name1=""
 contactcategory=""
 n=201
 customersall.each do |@customersall|
	if@customersall.labelnumber==150
		contactcategory=""
		contactcategory=@customersall.labeldetails
	end
	
	if contactcategory=="Customer"
		if@customersall.labelnumber==201
		name+=@customersall.labeldetails
		end
		if @customersall.labelnumber==202
		name+=""+@customersall.labeldetails
		end
		if @customersall.labelnumber==204
		phonenum=Contact.find(:first,:conditions=>"labelnumber=250 and contactid=#{@customersall.contactid}")
		if phonenum.nil?
		name+=""+@customersall.labeldetails
		else
		name+=""+@customersall.labeldetails+";"+phonenum.labeldetails
		end
		Customers<<PartyOption.new(@customersall.contactid, name)
		name=""
		end
	end
	
	if contactcategory=="Employee"
		if@customersall.labelnumber==201
		name+=@customersall.labeldetails
		end
		if @customersall.labelnumber==202
		name+=""+@customersall.labeldetails
		end
		if @customersall.labelnumber==204
		name+=""+@customersall.labeldetails
		Employees<<PartyOption.new(@customersall.contactid, name)
		name=""
		end
	end
	
	if contactcategory=="Friend"
		if@customersall.labelnumber==201
		name+=@customersall.labeldetails
		end
		if @customersall.labelnumber==202
		name+=""+@customersall.labeldetails
		end
		if @customersall.labelnumber==204
		name+=""+@customersall.labeldetails
		Friends<<PartyOption.new(@customersall.contactid, name)
		name=""
		end
	end
	
	if contactcategory=="Owner"
		if@customersall.labelnumber==201
		name+=@customersall.labeldetails
		end
		if @customersall.labelnumber==202
		name+=""+@customersall.labeldetails
		end
		if @customersall.labelnumber==204
		name+=""+@customersall.labeldetails
		Owner<<PartyOption.new(@customersall.contactid, name)
		name=""
		end
	end
	
	if contactcategory=="GroupCompany"
		if @customersall.labelnumber==205
		name+=@customersall.labeldetails
		GroupCompany<<PartyOption.new(@customersall.contactid, name)
		name=""
		end
	
	end
	
	if contactcategory=="Supplier"
		if @customersall.labelnumber==151
			name1+=@customersall.labeldetails
		end
				
			
		if @customersall.labelnumber==205
			name=@customersall.labeldetails
			# FOR utility accounts need 9120 at least
			if name1=="UtilityAccount"
				serviceall=Contact.find(:all, :order=>["labelnumber ASC"], :conditions=>"labelnumber in (9120,9220,9320,9420) and contactid=#{@customersall.contactid}")
				serviceall.each do |@serviceall|
					serviceid="/"+@serviceall.labeldetails
					name+=serviceid
					Utilities<<PartyOption.new(@customersall.contactid, name)
					serviceid=""
					name=@customersall.labeldetails
				end			
			else
			Suppliers<<PartyOption.new(@customersall.contactid, name)
			name=""
		end
		    name=""
			name1=""
		end
		
	end
	
	if contactcategory=="BankA/c"
		if@customersall.labelnumber==151
		name+=@customersall.labeldetails
		end
		if @customersall.labelnumber==152
		name+=""+@customersall.labeldetails
		end
		if @customersall.labelnumber==205
		name+=@customersall.labeldetails
		BankAccounts<<PartyOption.new(@customersall.contactid, name)
		name=""
		end
	end
		
 end

PartySelection<<PartyOption.new("","Choose")
CustomerSelection<<PartyOption.new("15","General Customer")
PARTY_OPTIONS=[PartySelection,Customers, Owner, GroupCompany,Employees, Suppliers, BankAccounts,Utilities, Friends]
CUSTOMER_OPTIONS=[CustomerSelection,Customers, Owner, GroupCompany,Employees, Suppliers, BankAccounts,Utilities, Friends]
Supplier_OPTIONS=[PartySelection, Employees, Suppliers, Owner]
Employee_OPTIONS=[PartySelection, Employees, Owner]