class Rcity::Country
  include Mongoid::Document
  field :code, :type => String
  field :name, :type => String
  field :lat, :type => Float
  field :lng, :type => Float
  field :coordinates, :type => Array
  field :loc, :type => Array
  field :address, :type => String

  has_many :provinces,:class_name=>"Rcity::Province"
  validates_presence_of :code,:name
  validates_uniqueness_of :code
end
