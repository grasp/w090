class Rcargo::CargoPackage
   include Mongoid::Document

   field :code
   field :name
   
   validates_presence_of :code,:name
   validates_uniqueness_of :code
   validates_uniqueness_of :name
   index :code
   
end
