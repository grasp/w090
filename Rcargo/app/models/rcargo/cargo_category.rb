class Rcargo::CargoCategory 
   include Mongoid::Document
     field :code
     field :name
     belongs_to :cargobigcategory ,:class_name=>"Rcargo::CargoBigCategory"
end
