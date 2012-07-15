# coding: utf-8
module Rcargo
class  Cargo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Rcity::ChengsHelper
  include Rcargo::CargosHelper
  # cattr_reader :per_page
  # @@per_page = 20      
  # cargo self info
  field :name
  field :weight, :type=>String
  field :unit, :type=>String 

  field :zuhuo, :type=>String
  field :expire, :type=>String
  field :comments, :type=>String
  field :status, :type=>String
  field :isself,:type=>String #what is the source of cargo

  field :price, :type=>String
  field :punit, :type=>String 

  #for not go back to find stock_cargo

  field :packagen, :type=>String
  field :big_cate, :type=>String
  field :cate, :type=>String

  # important line info
  field :line, :type=>String
  field :fcityn, :type=>String
  field :tcityn, :type=>String
  field :fcityc, :type=>String
  field :tcityc, :type=>String  

  #below is for phone concern, we need add this two field when we create cargo
  field :mphone, :type=>String #we can index this phone for his statistic
  field :fphone, :type=>String
  
  # from site
  field :fsite, :type=>String
  field :priority, :type=>Integer #show priority
  field :timetag    
  field :posted, :type=>String
  
  #important information
  field :zaddr, :type=>String
  field :ztime, :type=>String
  field :xieaddr, :type=>String

  belongs_to :user,:class_name=>"Ruser::User"
  belongs_to :stock_cargo,:class_name=>"Rcargo::StockCargo"
  
  #is contact information should be inside Ruser, right?
  field :contact, :type=>String #this is for raw display of grased data
  #field :user_contact_id
  
 # field :company
  #field :company_id
  
  
  # statistic
  #field :total_baojia, :type=>Integer
  #field :total_xunjia, :type=>Integer
  #field :total_match, :type=>Integer
  #field :total_click, :type=>Integer
  #field :tousu, :type=>Integer

 # has_one :cargostatistic,:class_name=>"Rcargo::CargoStatistic"
  # belongs_to :company,:class_name=>"Rcompany::Company"

 # field :cj_truck_id
 # field :cj_quote_id
 # field :cj_user_id
 #field :cj_company_id
      

  #field :stock_cargo_id
  
  #validates_presence_of :fcityc,:tcityc   #remove cate_name, could be empty from grasp
  validates_presence_of :fcityn,:tcityn   #remove cate_name, could be empty from grasp

  index ([[:fsite,Mongo::ASCENDING],[:updated_at,Mongo::ASCENDING],[:status,Mongo::ASCENDING],[:fcityc,Mongo::ASCENDING],[:tcityc,Mongo::ASCENDING]])
  
 
 before_create:check_unique

#  after_create:notify,:expire
#after_create :expire
  def check_unique
     repeated=Rcargo::Cargo.where(:name=>self.name,:fcityc=>self.fcityc,:tcityc=>self.tcityc,:ruser_user_id=>self.ruser_user_id,:status=>"正在配车",
     :fsite=>self.fsite).count 
  #  repeated=Rcargo::Cargo.where(:name=>self.name,:fcityc=>self.fcityc,:tcityc=>self.tcityc,:status=>"正在配车",:fsite=>self.fsite).count 
     # puts "repeated=#{repeated}"
     repeated > 0 ? (return false):(return true)
  end

  def expie222
    begin
      ActionController::Base.new.expire_fragment("cargos_allcity_1")
      ActionController::Base.new.expire_fragment("cargos_allcity_1")
      ActionController::Base.new.expire_fragment("provincecargo")
      ActionController::Base.new.expire_fragment("users_center_#{self.user_id}")    
      city_level(self.fcityc)[1].each do |city|
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_")
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_city")
      end
      city_level(self.tcityc)[1].each do |city|
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_")
        ActionController::Base.new.expire_fragment("cargo_city_#{city}_city")#this is for region code is same as city code issue
      end
    rescue
      puts "expire cargo fail"
    end
  end
  
     
end
end