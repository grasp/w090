# coding: utf-8
class  Rcargo::Cargo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Rcity::ChengsHelper
  include Rcargo::CargosHelper
  # cattr_reader :per_page
  # @@per_page = 20      
  # cargo self info
  field :weight, :type=>String
  field :zuhuo, :type=>String
  field :bulk, :type=>String
  field :expire, :type=>String
  field :comments, :type=>String
  field :status, :type=>String
  field :isself,:type=>String #what is the source of cargo
  field :price, :type=>String
  field :punit, :type=>String 

  #for not go back to find stock_cargo
  field :cate, :type=>String
  field :packag, :type=>String
  field :bigcate, :type=>String

  # important line info
  field :line, :type=>String
  field :fcityn, :type=>String
  field :tcityn, :type=>String
  field :fcityc, :type=>String
  field :tcityc, :type=>String   



  #below is for phone concern, we need add this two field when we create cargo
  field :mphone, :type=>String
  field :fphone, :type=>String
  
  belongs_to :user,:class_name=>"Ruser::User"
  belongs_to :company,:class_name=>"Rcompany::Company"

  #is contact information should be inside Ruser, right?
  #field :contact, :type=>String
  #field :user_contact_id
  
  field :company
  #field :company_id
  
  
  
  # from site
  field :fsite, :type=>String
  field :priority, :type=>Integer #show priority
  field :timetag    
  field :posted, :type=>String
  
  #important information
  field :zaddr, :type=>String
  field :ztime, :type=>String
  field :xieaddr, :type=>String
      
  # statistic
  #field :total_baojia, :type=>Integer
  #field :total_xunjia, :type=>Integer
  #field :total_match, :type=>Integer
  #field :total_click, :type=>Integer
  #field :tousu, :type=>Integer

  has_one :cargostatistic,:class_name=>"Rcargo::CargoStatistic"
      
 # field :cj_truck_id
 # field :cj_quote_id
 # field :cj_user_id
 #field :cj_company_id
      
  belongs_to :stock_cargo,:class_name=>"Rcargo::StockCargo"
  #field :stock_cargo_id
  
  validates_presence_of :fcity_code,:tcity_code   #remove cate_name, could be empty from grasp

  index ([[:from_site,Mongo::ASCENDING],[:updated_at,Mongo::ASCENDING],[:status,Mongo::ASCENDING],[:fcity_code,Mongo::ASCENDING],[:tcity_code,Mongo::ASCENDING]])
  
 
  before_create:check_unique

  after_create:notify,:expire
  def check_unique
     repeated=Cargo.where(:cate_name=>self.cate_name,:line=>self.line,:user_id=>self.user_id,:status=>"正在配车",
     :contact=>self.contact,:from_site=>self.from_site ,:mobilephone=>self.mobilephone,:fixphone=>self.fixphone).count 
      puts "repeated=#{repeated}"
  if  repeated > 0
      return false
  end
      return true
  end

  def expire
    begin
      ActionController::Base.new.expire_fragment("cargos_allcity_1")
      ActionController::Base.new.expire_fragment("cargos_allcity_1")
      ActionController::Base.new.expire_fragment("provincecargo")
      ActionController::Base.new.expire_fragment("users_center_#{self.user_id}")    
      city_level(self.fcity_code)[1].each do |city|
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_")
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_city")
      end
      city_level(self.tcity_code)[1].each do |city|
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_")
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_city")#this is for region code is same as city code issue
      end
    rescue
      puts "expire cargo fail"
    end
  end
  
     
end
