class Rcargo::StockCargo
  #  belongs_to :users
   include Mongoid::Document
   include Mongoid::Timestamps
    #category related
      field :name
      field :big_cate,:type=>String
      #packakge related
      field :packagen
      field :packagc

      #dun/fang/jian
      field :unit

      #expired/invalid/normal
      field :status,:type=>String
      
      #weight and bulk
      field :ku_weight,:type=>String
      field :ku_bulk,:type=>String    
      
      #field :sent_weight,:type=>Float
      #field :sent_bulk,:type=>Float          
      field :totals

      #Statistic
      field :valid_cargo,:type=>Integer
      #status
      field :status,:type=>String
      
      #define for search
     field :cangkus
    # field :user_id 
     field :company_id

     belongs_to :cargo_category ,:class_name=>"Rcargo::CargoCategory"
     belongs_to :user,:class_name=>"Ruser::User"
     has_many :cargos,:class_name=>"Rcargo::Cargo"

end
