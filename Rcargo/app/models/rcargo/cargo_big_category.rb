class Rcargo::CargoBigCategory
   include Mongoid::Document

   field :code
   field :name
   has_many :categories,:class_name=>"Rcargo::CargoCategory"
   
end