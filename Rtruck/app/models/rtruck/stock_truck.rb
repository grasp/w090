# coding: utf-8
module Rtruck
class StockTruck 
  include Mongoid::Document
  include Mongoid::Timestamps
 # include Mongoid::Spacial::Document
  #belongs_to :users
  has_many :trucks,:class_name=>"Rtruck::Truck"
  #stock truck basic info
  field :paizhao,:type=>String
  field :dunwei,:type=>String
  field :length,:type=>String
  field :usage,:type=>String
  field :shape,:type=>String
  field :gps,:type=>String
  field :isself,:type=>String
  field :favoc,:type=>String
  field :favol,:type=>String

  #Manufacture info
  field :pinpai,:type=>String
  field :xinghao,:type=>String
  field :buyedat,:type=>String

  #driver info
  field :driver,:type=>String
  field :dphone,:type=>String      
  #owner info
  field :owner,:type=>String
  field :ophone,:type=>String      
  #owner info
  field :business,:type=>String
  field :bphone,:type=>String
  # contact inforamtion
  field :cphone,:type=>String #car phone

  
  field :comments,:type=>String

  #status
  field :status,:type=>String

  # for feature usage
  #field :truck_license_id
  #field :truck_owner_id
  
  #dingwei
  field :bind 
  field :lat, :type=>Float
  field :lng, :type=>Float
  field :speed, :type=>Float
  field :timgtag
 # field :loc,:type=>Array,  spacial: true
  field :report_at
  
  #to identify group    
  field :truckgroup_id
  field :group
 # spacial_index :loc

  validates_presence_of :paizhao 
  validates_uniqueness_of :paizhao ,:message=>"该牌照车子已经存在."
  belongs_to:user ,:class_name=>"Ruser::User"
  #belongs_to: company,:class_name=>"Rcompany::Company"
end
end
