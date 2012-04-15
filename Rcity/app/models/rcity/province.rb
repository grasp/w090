class Rcity::Province
  include Mongoid::Document
  field :code, :type => String
  field :name, :type => String
  field :lat, :type => Float
  field :lng, :type => Float
  field :coordinates, :type => Array
  field :loc, :type => Array
  field :address, :type => String
  belongs_to :country,:class_name=>"Rcity::Country"
end
