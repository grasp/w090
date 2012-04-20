class Rcargo::CargoCategory 
   include Mongoid::Document
     field :code
     field :name
    belongs_to :cargo_big_category,:class_name=>"Rcargo::CargoBigCategory",:inverse_of=>:bigcategory
end
