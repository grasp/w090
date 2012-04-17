class Rcity::Province
  include Mongoid::Document
  field :code, :type => String
  field :name, :type => String
  field :lat, :type => Float
  field :lng, :type => Float
  field :coordinates, :type => Array
  field :loc, :type => Array
  field :address, :type => String

  #belong to 
  belongs_to :country,:class_name=>"Rcity::Country"
  
  #has_many
  has_many :regions,:class_name=>"Rcity::Region"
 
  #validator
  validates_presence_of :code,:name
  validates_uniqueness_of :code
  #cache
end
