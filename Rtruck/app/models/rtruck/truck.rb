# coding: utf-8
class Rtruck::Truck 
  include Mongoid::Document
  include Mongoid::Timestamps
    include Rcity::ChengsHelper
  #belongs_to :users
  #belongs_to :stock_trucks
  #has_many :inqueries
  #has_many :quotes
  
  #repeat stock_truck info for not go back search
      field  :paizhao,:type=>String
      field  :dunwei,:type=>String
      field  :length,:type=>String
      field  :shape,:type=>String
      field  :usage,:type=>String

      field  :driver,:type=>String
      field  :dphone,:type=>String
      field  :cphone,:type=>String

      #truck info
      field  :expire,:type=>String
      field  :status,:type=>String
      field  :comments,:type=>String
      field  :huicheng,:type=>String
      field  :contact,:type=>String

  
     field  :mphone,:type=>String
     field  :fphone,:type=>String

      #line info
      field  :line,:type=>String
      field  :fcityn,:type=>String
      field  :tcityn,:type=>String
      field  :fcityc,:type=>String
      field  :tcityc,:type=>String    

      
     # field :user_name,:type=>String 
      #field :company_name,:type=>String     

       
      #for future usage
      #field  :truck_pingjia_id
      #field  :truck_status_id
      #field  :tstatistic_id 
      
      field :price,:type=>String
      field :price_unit,:type=>String

     # add more le
     field :from,:type=>String
    #statistic related
    # field :total_baojia,:type=>Integer
    # field :total_xunjia,:type=>Integer
     #field :total_match,:type=>Integer
    # field :total_click,:type=>Integer
   
      #chenjiao record   
     # field :cj_cargo_id
      #field :cj_quote_id
     # field :cj_user_id
     # field :cj_company_id
      
      # external search
     # field  :company_id
     # field  :user_id
     # field  :stock_truck_id
     # field  :user_contact_id
     belongs_to :stock_truck,:class_name=>"Rtruck::StockTruck"
      belongs_to :user,:class_name=>"Ruser::User"
      index ([[:from,Mongo::ASCENDING],[:updated_at,Mongo::ASCENDING],[:status,Mongo::ASCENDING],[:fcityc,Mongo::ASCENDING],[:tcityc,Mongo::ASCENDING]])
  before_create:check_unique
  after_save:expireaaa
       
      
    def check_unique
   if self.from!="quzhou"
    repeated=Rtruck::Truck.where(:paizhao=>self.paizhao,:line=>self.line,:user_id=>self.user_id,:status=>"正在配货",
            :comments=>self.comments,:from_site=>self.from).count
   else
        repeated=Rtruck::Truck.where(:line=>self.line,:user_id=>self.user_id,:status=>"正在配货",
            :comments=>self.comments,:from_site=>self.from).count
   end
   # puts "repeated.size=#{repeated.size}"
    unless repeated==0
       errors.add(:base,"不能重复发布车源信息")
      return false
    end
    return true
     end
     
     def expireaaa
    controller_base=ActionController::Base.new
    controller_base.expire_fragment("trucks_allcity_1")
    controller_base.expire_fragment("trucks_allcity_1")
    controller_base.expire_fragment("provincetruck")
    controller_base.expire_fragment("users_center_#{self.user_id}")    
    unless self.fcityc.blank?
    city_level(self.fcityc)[1].each do |city|
     controller_base.expire_fragment("truck_city_#{city}_")
     controller_base.expire_fragment("truck_city_#{city}_city")
    end
    end
    unless self.tcityc.blank?
    city_level(self.tcityc)[1].each do |city|
      controller_base.expire_fragment("truck_city_#{city}_")
      controller_base.expire_fragment("truck_city_#{city}_city")
    end
    end
  end
 
end
