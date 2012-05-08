class Rcity::Region
  include Mongoid::Document
  field :code, :type => String
  field :name, :type => String
  field :lat, :type => Float
  field :lng, :type => Float
  field :coordinates, :type => Array
  field :loc, :type => Array
  field :address, :type => String
 
  #belong to 
  belongs_to :province,:class_name=>"Rcity::Province"

  #has many
  has_many :chengs,:class_name=>"Rcity::Cheng"
  #validator
  validates_presence_of :code,:name
  validates_uniqueness_of :code
 # cache
end
