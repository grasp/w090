class Rcargo::CargoBigCategory
   include Mongoid::Document

   field :code
   field :name
   has_many :categories,:class_name=>"Rcargo::CargoCategory"
   
   validates_presence_of :code,:name
   validates_uniqueness_of :code
   validates_uniqueness_of :name
   index :code
   
end