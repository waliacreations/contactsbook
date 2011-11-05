class Contact < ActiveRecord::Base

##to ensure labeldetails are not blank:
  validates_presence_of(:labeldetails, :message=>"Do not enter blank values!!")
  
  #using will_paginate plugin
  cattr_reader :per_page
  @@per_page = 50


TITLE_TYPES=[
	["Mr.", "Mr."],
	["Mrs.", "Mrs."],
	["Miss", "Miss"],
	["Master","Master"]  
	].freeze
	
	COMPANY_TYPES=[
	["Proprietorship","Proprietorship"],
	["PrivateLimited","PrivateLimited"],
	["Partnership","Partnership"],
	["PublicLimited","PublicLimited"],
  ["GovernmentDepartment/Agency","Government"], 
	["Unregistered","Unregistered"],
	].freeze
	
  PERSONAL_GROUPS=[
    ["school","school"],
    ["car-pool","car-pool"],
    ["locality","locality"],
    ["networking","networking"],
    ["college/univ.","college"],
    ["work","work"], 
    ["social","social"],  
    ["gym","gym"],
    ["hobby","hobby"],    
     ].freeze
	
  POSTS=[
    ["OWNER","OWNER"],
    ["GENERAL MANAGER","GENERAL MANAGER"],
    ["PRESIDENT","PRESIDENT"],
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
	
PLACES_GROUPS=[
    ["ChineeseRestaurant", "ChineeseRestaurant"],
    ["IndianRestaurant", "IndianRestaurant"],
    ["ItalianRestaurant","ItalianRestaurant"],
    ["JapaneeseRestaurant/Sushi","JapaneeseRestaurant/Sushi"],
     ["Pizza","Pizza"],
     ["Deli","Deli"],
     ["AmericanDiner","AmericanDiner"],
    ["Cafe","Cafe"],
    ["EnglishRestaurant/Pub","CreditCarda/c"],
    ["Utility","Utility"],
    ["GroupCompany", "GroupCompany"],
    ].freeze
	
	
  PLACES_TYPES=[
      ["Restaurant", "Restaurant"],
      ["Gym", "Gym"],
      ["Spa","Spa"],
      ["Moviehall/Theatre","Moviehall/Theatre"],
      ["Market/ShoppingStreet","Market/ShoppingStreet"],
      ["ShoppingMall","ShoppingMall"],
      ["Temple", "Temple"],
      ["Mosque", "Mosque"],
      ["Gurudwara", "Gurudwara"],
      ["Shop","Shop"],
      ["Bank", "Bank"],
      ["TaxDepartment","TaxDepartment"],
      ["UtilityCompany","UtilityCompany"],
      ["CommunicationsCompany","CommunicationsCompany"],
      ["SocietyClub", "SocietyClub"],
      ["Website","Website"],
      ["Office","Office"],
      ["Home","Home"],
      ["Suppliers","Suppliers"],
      ["TouristLandmark","TouristLandmark"],
      ["Palace/Fort","Palace/Fort"],
      ["Museum","Museum"],
      ["School/College/Academy","School/College/Academy"],
      ["Lake","Lake"],
      ["Zoo","Zoo"],
      ["Dealership","Dealership"],  
        
      ].freeze
   
	
  PRODUCT_TYPES=[
        ["AirTravel", "Restaurant"],
        ["RailTravel", "Gym"],
        ["Lodging","Spa"],
        ["Food","Moviehall/Theatre"],
        ["Movie/Theatre","Market/ShoppingStreet"],
        ["Communication","ShoppingMall"],
        ["Religous", "Temple"],
        ["Computer&Printers", "Mosque"],
        ["Car", "Gurudwara"],
        ["Finance/Investment", "Bank"],
        ["Accounting/Tax","TaxDepartment"],
        ["SocialService", "SocietyClub"],
        ["PR/Marketing","Website"],
        ["MobilePhones","Office"],
        ["Apparel","Home"],
        ["Shoes","Suppliers"],
        ["Bags","TouristLandmark"],
        ["Jewellery","Palace/Fort"],
        ["Watch","Museum"],
        ["Education","School/College/Academy"],
        ["Cosmetics","Lake"],
        ["Maintenance&Repair","Zoo"],
        ["Insurance","Dealership"],            
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
	
 #friend/relative/acquaintance will be for personal contact
 #doctor/clinic/hospital/laboratory/chemist/physiotherapy for medical contact
 #ambulance/fire/police/doctor/relative/lawyer for emergency
 #bank/business/supplier/govt./employee/supplier/tax/customer/investments/assets for work
 #gym/spa/saloon/massage for health&beauty
 #tickets/hotel/inn/guesthouse/b&b for travel
 #projects/tasks/to-do list/design/mfr./  for project
	
	#for shopping&entertainment
	#restaurant/grocery/superstore/ice-cream/cafe/pizza/  
	#italian/indian/chineese/continental/buffet/bar/
	#japaneese/north-east/bengali/malabar/southindian 
	#movies/circus/theatre/bowling/golf/shoppingmall/highstreet
  #for shopping&entertainment
	
	PEOPLE_TYPES=[
   ["Friend", "Friend"],
   ["Relative/Family", "Relative/Family"],
    ["Customer","Customer"], 
    ["Supplier","Supplier"], 
    ["Employee","Employee"], 
    ["Student","Student"],   
    ["BusinessAssociates","BusinessAssociates"],
    ["Colleagues","Colleagues"],     
   ["Supplier/Agents", "Supplier/Agents"],  
   ["Guru/Mentor","Guru/Mentor"],   
   ].freeze   
     
   
   
  ENTITY_TYPES=[
	["Friend", "Friend"],
	["Relative", "Relative"],
	["Acquaintance", "Acquaintance"],  
  ["Mentor","Mentor"],  
  ["Teacher/Expert","Teacher"],   
  ].freeze
	
  
	
	ENTITY_TYPESOLD=[
	["Customer", "Customer"],
	["BankA/c","BankA/c"],
	["Restaurants/Hotels","Restaurants"],
	["Clubs/Associations","Clubs"],  
	["Employee","Employee"],
	["Supplier/Service provider", "Supplier"],
	["Utilities","Utilities"],
	["Emergency","Emergency"],    
	["NGO/Organisation/Association", "Organisation"],
	["RatingsAgency/Critics/Judges","Critics"],
	["TestingLab/Weights&Measure","Test"],  
	["Hospital/Clinic","Hospital"],  
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
	
  CITY_TYPES=[
   ["Delhi", "Delhi"],
   ["Gurgaon", "Gurgaon"],
   ["Noida", "Noida"],
   ["Faridabad", "Faridabad"],
   ].freeze
	
	
	STATE_TYPES=[
	["Delhi", "Delhi"],
	["Haryana", "Haryana"],
	["Uttar Pradesh", "Uttar Pradesh"],
	["Rajasthan", "Rajasthan"],
	].freeze
	
 COUNTRY_TYPES=[
  ["India", "India"],
  ["USA", "USA"],
  ["UK", "UK"],
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